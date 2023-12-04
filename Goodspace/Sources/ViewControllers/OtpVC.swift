//
//  OtpVC.swift
//  Goodspace
//
//  Created by Amit Shah on 05/12/23.
//

import UIKit

class OtpVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func otpacr(_ sender: Any) {
        AppSettings.setValue(token: "abc", countryCode: "ccode", mobileNo: "123")
        openVC(DashboardVC.self)
    }

}
