//
//  DashboardVC.swift
//  Goodspace
//
//  Created by Amit Shah on 05/12/23.
//

import UIKit

class DashboardVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func uiactions(_ sender: Any) {
        if AppSettings.isLogout(){
            moveToRootVC()
        }
    }
    
}
