//
//  AppSettings.swift
//  Goodspace
//
//  Created by Amit Shah on 04/12/23.
//

import Foundation


struct AppSettings{

    static var token: String? {
        get {
            return UserDefaults.standard.string(forKey: "token")
        }
    }
    
    static var countryCode: String? {
        get {
            return UserDefaults.standard.string(forKey: "countryCode")
        }
    }
    
    static var mobileNo: String? {
        get {
            return UserDefaults.standard.string(forKey: "mobileNo")
        }
    }
    
    static var isActiveUser: Bool {
        
        get {
            return UserDefaults.standard.bool(forKey: "login")
        }
    }
    
    static func setValue(token: String, countryCode: String, mobileNo: String){
        
        let userDefault = UserDefaults.standard
        
        userDefault.setValue(token, forKey: "token")
        userDefault.setValue(countryCode, forKey: "countryCode")
        userDefault.setValue(mobileNo, forKey: "mobileNo")
        userDefault.setValue(true, forKey: "login")
        
        userDefault.synchronize()
        
    }
    
    static func isLogout() -> Bool{
        
        let userDefault = UserDefaults.standard
        
        userDefault.removeObject(forKey: "token")
        userDefault.removeObject(forKey: "countryCode")
        userDefault.removeObject(forKey: "mobileNo")
        userDefault.removeObject(forKey: "login")
        
        userDefault.synchronize()
        
        return !userDefault.bool(forKey: "login")
    }
}
