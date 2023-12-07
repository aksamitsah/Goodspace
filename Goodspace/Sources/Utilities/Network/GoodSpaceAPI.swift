//
//  Networking.swift
//  Goodspace
//
//  Created by Amit Shah on 04/12/23.
//

import Foundation


enum GoodSpaceAPI {
    case Login(country: String, mobile: String)
    case VerifyOTP(mobile: String, otp: String)
    case jobsListOnDashBoard
    case premiumProducts
    
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
            "Authorization": AppSettings.token ?? "",
            "device-id": AppFeature.currentDeviceID,
            "device-type": "ios"
        ]
        
        switch self {
        case .Login, .premiumProducts, .VerifyOTP, .jobsListOnDashBoard:
            return header
        }
        
    }

    
    var method: HTTPMethod{
        switch self {
        case .Login, .VerifyOTP:
            return .post
        case .premiumProducts, .jobsListOnDashBoard:
            return .get
        }
    }
    
    var path: String{
        switch self {
        case .Login:
            return "/api/d2/auth/v2/login"
        case .premiumProducts:
            return "/api/d2/manage_products/getInActiveProducts"
        case .VerifyOTP:
            return "/api/d2/auth/verifyotp"
        case .jobsListOnDashBoard:
            return "/api/d2/member/dashboard/feed"
        }
    }
    
    var body: Data? {
        
        var data = [String : String]()
        
        switch self {
        case .Login(country: let country, mobile: let mobile):
            data["number"] = mobile
            data["countryCode"] = country
        
        case .premiumProducts, .jobsListOnDashBoard: break
            
        case .VerifyOTP(mobile: let mobile, otp: let otp):
            data["number"] = mobile
            data["otp"] = otp
            
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
