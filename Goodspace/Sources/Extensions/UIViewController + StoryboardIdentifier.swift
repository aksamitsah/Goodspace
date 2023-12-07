//
//  UIViewController + StoryboardIdentifier.swift
//  Goodspace
//
//  Created by Amit Shah on 04/12/23.
//

import UIKit.UIViewController

extension UIViewController {
    
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}
