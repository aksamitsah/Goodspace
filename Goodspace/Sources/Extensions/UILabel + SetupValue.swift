//
//  UILabel + SetupValue.swift
//  Goodspace
//
//  Created by Amit Shah on 05/12/23.
//

import UIKit.UILabel

extension UILabel{
    func setupValue(value: String = "", for error: ValidationCheck = .`default`){
        text = value
        textColor = error.color == .systemGray5 ? .label : error.color
    }
}
