//
//  LoginModel.swift
//  Goodspace
//
//  Created by Amit Shah on 05/12/23.
//

import UIKit

struct LoginModel : Decodable{
    let message: String?
}


struct AuthModel{
    var mobile: String
    var countryCode: String
    var otp: String?
    var countryFlag: UIImage?
}
