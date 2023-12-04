//
//  HandleError.swift
//  Goodspace
//
//  Created by Amit Shah on 04/12/23.
//

import Foundation

enum HandleError: Error {
    
        case invalidResponse
        case invalidURL
        case invalidDecoding
        case custom(_ error: String)
        case message(_ error: Error?)
        
        var localizedDescription: String {
            switch self {
            case .invalidResponse:
                return "Invalid Response Code"
            case .invalidURL:
                return "Failed to create URL"
            case .invalidDecoding:
                return "Failed to Decode Data"
            case .custom(let error):
                return error
            case .message(let error):
                return error?.localizedDescription ?? ""
            }
    }
}
