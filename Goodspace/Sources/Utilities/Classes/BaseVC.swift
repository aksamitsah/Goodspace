//
//  BaseVC.swift
//  WISP QUIZ
//
//  Created by Amit Shah on 04/11/23.
//

import UIKit

class BaseVC: UIViewController {
    
    var data: Any?

    func openVC<T: BaseVC>(_ controllerType: T.Type, data: Any? = nil, animation: Bool = true) {
        if let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: controllerType.storyboardIdentifier) as? T {
            vc.data = data
            navigationController?.pushViewController(vc, animated: animation)
        }
    }
    
    func closeVC(animation: Bool = true){
        navigationController?.popViewController(animated: animation)
    }
    
    func moveToRootVC(animation: Bool = true){
        navigationController?.popToRootViewController(animated: animation)
    }
}

