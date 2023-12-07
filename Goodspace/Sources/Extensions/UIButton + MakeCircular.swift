//
//  UIButton+MakeCircular.swift
//  Goodspace
//
//  Created by Amit Shah on 05/12/23.
//

import UIKit.UIButton

extension UIButton {
    
    func makeCircular(radius: CGFloat = 10.0) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

