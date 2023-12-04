//
//  Networking.swift
//  Goodspace
//
//  Created by Amit Shah on 04/12/23.
//

import Foundation


enum GoodSpaceAPI {
    case Login(country: String, mobile: String)
    case premiumProducts
//    case categoryCountLookup(category: Int)
//    case globalCategoryCountLookup
//    case generateQuiz(amount: Int, category: Int?, difficulty: String?, type: String?)
}

extension GoodSpaceAPI: API{
    
    var scheme: HTTPScheme{
        return .https
    }
    
    var baseURL: String{
        return "api.ourgoodspace.com"
    }
    
    var headers: [String : String]? {
        
        let header = [
            "Authorization":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6NTMwNzEyMzQ3LCJpYXQiOjE3MDE3Mjc3MzZ9.-Zxesz3lDc-_E06MAgXo51jgiOuJfFIT7Ekg5ADPj-A",
            "device-id": AppFeature.currentDeviceID,
            "device-type": "ios"
        ]
        
        switch self {
        case .Login, .premiumProducts:
            return header
        }
        
    }

    
    var method: HTTPMethod{
        switch self {
        case .Login:
            return .post
        case .premiumProducts:
            return .get
        }
    }
    
    var path: String{
        switch self {
        case .Login:
            return "/api/d2/auth/v2/login"
        case .premiumProducts:
            return "/api/d2/manage_products/getInActiveProducts"
        }
    }
    
    var body: Data? {
        
        var data = [String : String]()
        
        switch self {
        case .Login(country: let country, mobile: let mobile):
            data["number"] = mobile
            data["countryCode"] = country
        case .premiumProducts: break
        }
        
        do{
            return data.isEmpty ? nil : try JSONEncoder().encode(data)
        }catch{
            Log.error("exception on Json Formetter")
            return nil
        }
    }
    
    var parameters: [URLQueryItem]? {
        return nil
    }
    
}
