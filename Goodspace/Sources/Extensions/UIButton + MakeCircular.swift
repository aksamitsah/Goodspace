//
//  UIButton+MakeCircular.swift
//  Goodspace
//
//  Created by Amit Shah on 05/12/23.
//

import UIKit

extension UIButton {
    
    func makeCircular() {
        self.layer.cornerRadius = 10.0
        self.clipsToBounds = true
    }
}

