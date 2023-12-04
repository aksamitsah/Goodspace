//
//  LoginModel.swift
//  Goodspace
//
//  Created by Amit Shah on 05/12/23.
//

import Foundation


struct LoginModel : Decodable{
    let message: String?
}


struct LoginModel2 : Decodable{
    let data: [LoginModel3]?
}

struct LoginModel3 : Decodable{
    let displayName: String?
    let productName: String?
}


