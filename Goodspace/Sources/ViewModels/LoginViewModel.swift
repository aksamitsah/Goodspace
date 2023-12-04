//
//  LoginViewModel.swift
//  Goodspace
//
//  Created by Amit Shah on 05/12/23.
//

import Foundation

final class LoginViewModel{
    
    var countryCode = "91"
    
    func getOTP(mobile: String, comp: @escaping (Result<Bool,HandleError>) -> Void){
        APIManager.request(endpoint: GoodSpaceAPI.Login(country: countryCode, mobile: mobile)) {
            (result: Result<LoginModel, HandleError>) in
            switch result{
            case .success(_):
                comp(.success(true))
            case .failure(let error):
                comp(.failure(error))
            }
        }
    }  
    

}
