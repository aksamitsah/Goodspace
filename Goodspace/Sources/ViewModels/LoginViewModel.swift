//
//  LoginViewModel.swift
//  Goodspace
//
//  Created by Amit Shah on 05/12/23.
//

import Foundation


final class LoginViewModel{
    
    var data: AuthModel
    
    init() {
        data = AuthModel(mobile: "", countryCode: "")
    }
    
    func getOTP(mobile: String, comp: @escaping (Result<String,HandleError>) -> Void){
        data.mobile = mobile
        
        //APP STORE CONNECT
        if mobile == APP_STORE.user.mobile && data.countryCode == APP_STORE.user.countryCode{
            
            DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 2.0) {
                APP_STORE.isTestUser = true
                comp(.success("Test Account Login"))
            }
            
            return
        }
        
        APIManager.request(endpoint: GoodSpaceAPI.Login(country: data.countryCode, mobile: mobile)) {
            (result: Result<LoginModel, HandleError>) in
            switch result{
            case .success(let data):
                comp(.success(data.message ?? ""))
            case .failure(let error):
                comp(.failure(error))
            }
        }
    }
}
