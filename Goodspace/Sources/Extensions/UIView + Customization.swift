//
//  UIView + Customization.swift
//  Goodspace
//
//  Created by Amit Shah on 05/12/23.
//

import UIKit.UIView

extension UIView{
    
    func defaultTheme(cornerRadius: CGFloat = 6.0, borderWidth: CGFloat = 1.6, borderColor: UIColor = UIColor.systemGray5, backgroundColor: UIColor = UIColor.systemGray6){
        
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        self.backgroundColor = backgroundColor
        
    }

    func defaultTheme2(cornerRadius: CGFloat = 4.0, borderWidth: CGFloat = 1, borderColor: UIColor = .clear, backgroundColor: UIColor? = nil){
        
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        
        if let backgroundColor {
            self.backgroundColor = backgroundColor
        }
        
    }
    
    enum ValidationCheck{
        
        case error
        case clear
        case fill
        case `default`
        
        var color: UIColor{
            switch self {
            case .error:
                return .systemRed
            case .clear:
                return .systemGray5
            case .default, .fill:
                return .systemGray5
            }
        }
        
        var colorOTP: UIColor{
            switch self {
            case .error:
                return .systemRed
            case .clear, .fill:
                return .clear
            case .default:
                return .primaryColor
            }
        }
    }
    
    func updateTheme(type: ValidationCheck = .`default`, textField: UITextField? = nil, view2: UIView? = nil){
     
        defaultTheme(borderColor: type.color)
        textField?.textColor = (type.color == UIColor.systemRed) ? UIColor.systemRed : UIColor.label
        view2?.backgroundColor = type.color
        
    }
    
    
    func updateOTPTheme(type: ValidationCheck = .`default`, textField: UITextField? = nil){
        textField?.textColor = (type.colorOTP == .systemRed) ? .systemRed : .secondaryColor
        defaultTheme(borderColor: (type == .fill) ? .primaryColor : type.colorOTP , backgroundColor: (type == .fill) ? .primaryColor : .clear)
    }
    
}

