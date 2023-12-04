//
//  AppFeature.swift
//  Goodspace
//
//  Created by Amit Shah on 04/12/23.
//

import UIKit


class AppFeature{
    
    static var currentDeviceID: String{
        return UIDevice.current.identifierForVendor?.uuidString ?? "Na"
    }
    
}
