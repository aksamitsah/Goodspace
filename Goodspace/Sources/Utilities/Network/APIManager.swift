//
//  APIManager.swift
//  Goodspace
//
//  Created by Amit Shah on 04/12/23.
//

import Foundation


typealias Handler<T> = (Result<T,HandleError>) -> Void

enum HTTPMethod: String {
    case delete = "DELETE"
    case get = "GET"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
}

enum HTTPScheme: String {
    case http
    case https
}


protocol API {
    var scheme: HTTPScheme { get }
    var baseURL: String { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var parameters: [URLQueryItem]? { get }
    var method: HTTPMethod { get }
}



final class APIManager {
    
    private class func buildURL(endpoint: API) -> URLComponents {
        var components = URLComponents()
        components.scheme = endpoint.scheme.rawValue
        components.host = endpoint.baseURL
        components.path = endpoint.path
        if let ds = endpoint.parameters, !ds.isEmpty{
            components.queryItems = ds
        }
        return components
    }
    
    
    class func request<T: Decodable>(endpoint: API, completion: @escaping Handler<T>) {
        
        let components = buildURL(endpoint: endpoint)
        
        guard let url = components.url else {
            Log.error("URL creation error")
            completion(.failure(.invalidURL))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = endpoint.method.rawValue
        
        if let rowHeader = endpoint.headers, !rowHeader.isEmpty{
            for (key, value) in rowHeader{
                urlRequest.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if endpoint.body != nil{
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = endpoint.body
        }
        
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            
            guard let data, error == nil else {
                completion(.failure(.message(error)))
                Log.error(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                Log.error("Failed Response Code")
                return
            }
            
            do{
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
                Log.info("Sucessful featched")
            }catch{
                completion(.failure(.message(error)))
                Log.error(error)
            }
        }
        
        dataTask.resume()
    }
}
