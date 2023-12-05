//
//  Validation.swift
//  Goodspace
//
//  Created by Amit Shah on 05/12/23.
//

import Foundation

struct Validation{
    static func isValidNumber(phoneNumber: String) -> Bool{
        let phoneRegex = #"^\d{10}$"#
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phoneNumber)
    }
}
