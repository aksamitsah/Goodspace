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
    
    
    func setImageWithProgress(lineWidth: CGFloat = 4, stroke: CGFloat = 1, color : UIColor = .greenColor, image: UIImageView, imageUrl: String, placeholder: UIImage? = nil){
        
        let centerPoint = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let circleRadius: CGFloat = bounds.width / 2 * 0.83

        let circlePath = UIBezierPath(
            arcCenter: centerPoint,
            radius: circleRadius,
            startAngle: CGFloat(-0.5 * Double.pi),
            endAngle: CGFloat(1.5 * Double.pi),
            clockwise: true
        )

        let progressCircle = CAShapeLayer()
        progressCircle.path = circlePath.cgPath
        progressCircle.strokeColor = color.cgColor
        progressCircle.fillColor = UIColor.clear.cgColor
        progressCircle.lineWidth = lineWidth
        progressCircle.strokeStart = 0.0
        progressCircle.strokeEnd = stroke

        layer.addSublayer(progressCircle)

        image.tintColor = .accent
        image.setImage(urlString: imageUrl, isRoundImg: true, placeholder: placeholder)
    }
}
