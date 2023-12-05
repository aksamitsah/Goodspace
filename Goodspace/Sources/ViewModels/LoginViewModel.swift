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
