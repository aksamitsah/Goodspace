//
//  ProfileVC.swift
//  Goodspace
//
//  Created by Amit Shah on 06/12/23.
//

import UIKit

class ProfileVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .gray.withAlphaComponent(0.5)
        
    }
    
    @IBAction func logoutBtn(_ sender: Any) {
        if AppSettings.isLogout() {
            moveToRootVC()
        }
    }
    

}
