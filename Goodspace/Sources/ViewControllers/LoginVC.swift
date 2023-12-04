//
//  ViewController.swift
//  Goodspace
//
//  Created by Amit Shah on 04/12/23.
//

import UIKit
import CountryPickerAKS

class LoginVC: BaseVC {

    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var countryPickerBtn: UIButton!
    @IBOutlet weak var mobileNoTF: UITextField!
    @IBOutlet weak var onBardingImageView: UIImageView!
    
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bottomView.layer.cornerRadius = 6.0
        bottomView.layer.borderWidth = 1.6
        bottomView.layer.borderColor = UIColor.systemGray5.cgColor
        
        isSlideKeyboard()
        mobileNoTF.addDoneButtonOnKeyboard()
        
        countryPickerBtn.setTitle(" ", for: .normal)
        countryPickerBtn.setImage("🇮🇳".emojToImage() ?? UIImage(), for: .normal)
        
    }

    @IBAction func onTapGetOTP(_ sender: UIButton) {
        
        guard let ds = mobileNoTF.text, !ds.isEmpty else {
            AppHelper.shared.showAlert(title: "Error", message: "Mobile Number Required", vc: self)
            return
        }
        
        viewModel.getOTP(mobile: ds) { [weak self] result in
            switch result{
            case .success(let data):
                if data{
                    DispatchQueue.main.async {
                        self?.openVC(OtpVC.self)
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    AppHelper.shared.showAlert(title: "Error", message: error.localizedDescription, vc: self)
                }
                
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        updateImage()
    }
    
    func updateImage(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            UIView.transition(with: self.onBardingImageView,
                              duration: 0.75,
                              options: .transitionCrossDissolve,
                              animations: {
                
                if self.onBardingImageView.tag == 3{
                    self.onBardingImageView.tag = 1
                }else{
                    self.onBardingImageView.tag = self.onBardingImageView.tag + 1
                }
                
                self.onBardingImageView.image = UIImage(named: "img_onbarding_\(self.onBardingImageView.tag)")
                
            }) { _ in
                self.updateImage()
            }
            
        }
    }
    
    @IBAction func countryPicker(_ sender: UIButton) {
        callCountryPicker()
    }
    
}


extension LoginVC{
    
    func callCountryPicker(){
        
        //Note Remove Config to display all country list
        
        CountryPicker.show(
            from: self,
            config: Config(
                data: CustomizeCountryList(
                    alterExisting: [
                        .displayOnly(
                            ["IN", "AU", "AE", "SA", "SG", "US"]
                        )]
                ))
        ){ result in
            switch result {
            case .success(let data):
                var numberString = data.dial_code
                self.viewModel.countryCode = String(numberString[numberString.index(after: numberString.startIndex)...])
                self.countryPickerBtn.setImage(data.emoji.emojToImage() ?? UIImage(), for: .normal)
            case .failure(let error):
                Log.error(error.localizedDescription)
            }
        }
    }
    
}

