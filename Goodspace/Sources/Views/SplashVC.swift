//
//  SplashVC.swift
//  Goodspace
//
//  Created by Amit Shah on 04/12/23.
//

import UIKit

class SplashVC: BaseVC {

    @IBOutlet weak var logoImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let img = UIImage.animatedImage(withGIFName: "ic_logo_animate"){
           logoImageView.image = img
        }else{
            Log.error("failed to rander gif image")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.4) {
            AppSettings.isActiveUser ? self.openVC(DashboardVC.self) : self.openVC(LoginVC.self)
        }
    }
    
}
