//
//  WorkModel.swift
//  Goodspace
//
//  Created by Amit Shah on 07/12/23.
//

import Foundation

struct JobDataModel : Decodable{
    
    let message: String?
    let status: Int?
    let data: [JobDataResponse]
    
    private enum CodingKeys: String, CodingKey {
            case message, status, data
        }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let ds = try? container.decode([JobDataResponse].self, forKey: .data){
            data = ds
        }else{
            data = []
        }
        
        message = try? container.decode(String.self, forKey: .message)
        status = try? container.decode(Int.self, forKey: .status)
    }
}

struct JobDataResponse : Decodable{
    
    let type: String
    let cardData: JobCardData?
    
    private enum CodingKeys: String, CodingKey {
            case type, cardData
        }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let ds = try? container.decode(String.self, forKey: .type){
            type = ds
        }else{
            type = ""
        }
        
        cardData = try? container.decode(JobCardData.self, forKey: .cardData)
    }
    
}

struct JobCardData : Decodable {
    
    let companyName: String
    
    let lowerworkex: Int?
    let upperworkex: Int?
    
    var experiance: String {
        return "\(lowerworkex ?? 0) - \(upperworkex ?? 0) Years"
    }
    
    let url: String

    let displayCompensation: String
    
    let relativeTime: String
    
    let location_city: String
    let title: String
    let hasApplied: Bool
    
    let userInfo: JobUserInfo
    let jobType: String
    
    
    private enum CodingKeys: String, CodingKey {
            case companyName, lowerworkex, upperworkex, url, displayCompensation, location_city, title, hasApplied, userInfo, jobType, relativeTime
        }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let ds = try? container.decode(String.self, forKey: .companyName){
            companyName = ds
        }else{
            companyName = "Not Found"
        }
        
        if let ds = try? container.decode(String.self, forKey: .url){
            url = ds
        }else{
            url = ""
        }
        
        if let ds = try? container.decode(String.self, forKey: .location_city){
            location_city = ds
        }else{
            location_city = "Na"
        }
        
        
        if let ds = try? container.decode(Bool.self, forKey: .hasApplied){
            hasApplied = ds
        }else{
            hasApplied = false
        }
        
        
        if let ds = try? container.decode(String.self, forKey: .title){
            title = ds
        }else{
            title = "Na"
        } 
        
        if let ds = try? container.decode(String.self, forKey: .relativeTime){
            relativeTime = ds
        }else{
            relativeTime = "Na"
        }
        
        if let ds = try? container.decode(JobUserInfo.self, forKey: .userInfo){
            userInfo = ds
        }else{
            userInfo = JobUserInfo(user_id: 0, image_id: "", name: "Na")
        }

        if let ds = try? container.decode([JobType].self, forKey: .jobType){
            jobType =  (ds.count > 0) ? ds.first?.job_type ?? "Na" : "Na"
        }else{
            jobType = "Na"
        }
        
        if let ds = try? container.decode(String.self, forKey: .displayCompensation){
            displayCompensation = ds
        }else{
            displayCompensation = "Na"
        }
       
        lowerworkex = try? container.decode(Int.self, forKey: .lowerworkex)
        upperworkex = try? container.decode(Int.self, forKey: .upperworkex)
        
        
    }
    
}


struct JobUserInfo : Decodable {
    
    let user_id: Int
    let image_id: String
    let name: String
    
}

struct JobType : Decodable {
    let job_type: String
}
