//
//  OtpModel.swift
//  Goodspace
//
//  Created by Amit Shah on 05/12/23.
//

import Foundation

struct OtpModel : Decodable{
    let message: String?
    let data: OtpResponse
}

struct OtpResponse : Decodable{
    
    var user_id: Int?
    var country_code: String?
    var image_id: String?
    var name: String?
    var email_id: String?
    var status: Int?
    var token: String?
    var mobile_number: String?
    var is_premium: String?
    var inviteLink: String?
    var isHiringSelected: Bool?
    
    private enum CodingKeys: String, CodingKey {
            case user_id, country_code, image_id, name, email_id, status, token, mobile_number, is_premium, inviteLink, isHiringSelected
        }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        user_id = try? container.decode(Int.self, forKey: .user_id)
        country_code = try? container.decode(String.self, forKey: .country_code)
        image_id = try? container.decode(String.self, forKey: .image_id)
        name = try? container.decode(String.self, forKey: .name)
        email_id = try? container.decode(String.self, forKey: .email_id)
        status = try? container.decode(Int.self, forKey: .status)
        token = try? container.decode(String.self, forKey: .token)
        mobile_number = try? container.decode(String.self, forKey: .mobile_number)
        inviteLink = try? container.decode(String.self, forKey: .inviteLink)
        is_premium = try? container.decode(String.self, forKey: .is_premium)
        isHiringSelected = try? container.decode(Bool.self, forKey: .isHiringSelected)

    }
    
}
