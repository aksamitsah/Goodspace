//
//  PremiumProduct.swift
//  Goodspace
//
//  Created by Amit Shah on 07/12/23.
//

import Foundation

struct PremiumProductModel : Decodable{
    
    let message: String?
    let status: Int?
    let data: [PremiumProductResponse]
    
    private enum CodingKeys: String, CodingKey {
            case message, status, data
        }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let ds = try? container.decode([PremiumProductResponse].self, forKey: .data){
            data = ds
        }else{
            data = []
        }
        
        message = try? container.decode(String.self, forKey: .message)
        status = try? container.decode(Int.self, forKey: .status)
    }
}


struct PremiumProductResponse : Decodable{
    
    let displayName: String
    let productName: String
    
    private enum CodingKeys: String, CodingKey {
            case displayName, productName
        }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let ds = try? container.decode(String.self, forKey: .displayName){
            displayName = ds
        }else{
            displayName = "Na"
        }
        
        if let ds = try? container.decode(String.self, forKey: .productName){
            productName = ds
        }else{
            productName = "Na"
        }
        
    }
}

