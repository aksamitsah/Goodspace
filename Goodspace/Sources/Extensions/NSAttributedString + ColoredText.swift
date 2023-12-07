//
//  NSAttributedString + ColoredText.swift
//  Goodspace
//
//  Created by Amit Shah on 05/12/23.
//

import UIKit.NSAttributedString

extension NSAttributedString {
    static func coloredText(_ text: String, color: UIColor, forSubstring substring: String, font: UIFont? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: substring)
        attributedString.addAttribute(.foregroundColor, value: color, range: range)
        if let font{
            attributedString.addAttribute(.font, value: font, range: range)
        }
        return attributedString
    }
}

