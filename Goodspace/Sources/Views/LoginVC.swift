//
//  ViewController.swift
//  Goodspace
//
//  Created by Amit Shah on 04/12/23.
//

import UIKit
import CountryPickerAKS

class LoginVC: BaseVC {

    @IBOutlet weak var responseMsg: UILabel!
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var countryPickerBtn: UIButton!
    @IBOutlet weak var mobileNoTF: UITextField!
    @IBOutlet weak var onBardingImageView: UIImageView!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        initilizeValue()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateSliderImage()
    }

    @IBAction func onTapGetOTP(_ sender: UIButton) {
        
        mobileNoTF.resignFirstResponder()
        
        if !checkValidation(textField: mobileNoTF){
            return
        }
        
        dataObserver()
        
    }
    
    @IBAction func countryPicker(_ sender: UIButton) {
        callCountryPicker()
    }
}


extension LoginVC: UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        _ = checkValidation(textField: textField)
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let text = textField.text ?? ""
        if text.isEmpty || text.count >= 10{
            _ = checkValidation(textField: textField)
        }
    }
}

extension LoginVC{
    
    func setupUI(){
        
        isSlideKeyboard()
        mobileNoTF.addDoneButtonOnKeyboard()
        
        mobileNoTF.delegate = self
        
        bottomView.updateTheme()
        
        (view.viewWithTag(201) as? UIButton)?.makeCircular()
        
    }
    
    func initilizeValue(){
        
        responseMsg.attributedText = NSAttributedString.coloredText("You will receive a 4 digit OTP ", color: UIColor.accent, forSubstring: "4 digit OTP ")
        
        (view.viewWithTag(101) as? UILabel)?.attributedText = NSAttributedString.coloredText("Please enter your phone number to sign in GoodSpace account.", color: UIColor.accent, forSubstring: "GoodSpace")
        
        //Setup Default India Country
        viewModel.data.countryCode = "91"
        countryPickerBtn.setTitle(" ", for: .normal)
        countryPickerBtn.setImage("🇮🇳".emojToImage() ?? UIImage(), for: .normal)
    }
    
    func checkValidation(textField: UITextField) -> Bool{
        
        if let text = textField.text, !text.isEmpty{
            
            let validation = Validation.isValidNumber(phoneNumber: text)
            
            if validation {
                responseMsg.setupValue()
                responseMsg.attributedText = NSAttributedString.coloredText("You will receive a 4 digit OTP ", color: UIColor.accent, forSubstring: "4 digit OTP ")
                bottomView.updateTheme(type: .clear, textField: mobileNoTF, view2: dividerView)
            } else {
                responseMsg.setupValue(value: "Enter Correct phone number", for: .error)
                bottomView.updateTheme(type: .error, textField: mobileNoTF, view2: dividerView)
            }
            
            return validation
            
        }else {
            
            responseMsg.setupValue()
            responseMsg.attributedText = NSAttributedString.coloredText("You will receive a 4 digit OTP ", color: UIColor.accent, forSubstring: "4 digit OTP ")
            bottomView.updateTheme(type: .clear, textField: mobileNoTF, view2: dividerView)
            
            return false
        }
    }
    
    func dataObserver(){
        AppHelper.shared.showProgressIndicator(view: self.view)
        viewModel.getOTP(mobile: mobileNoTF.text ?? "") { [weak self] result in
            switch result{
            case .success(let data):
                    DispatchQueue.main.async {
                        AppHelper.shared.hideProgressIndicator(view: self?.view)
                        self?.responseMsg.setupValue(value: data, for: .clear)
                        self?.openVC(OtpVC.self, data: self?.viewModel.data)
                    }
            case .failure(let error):
                DispatchQueue.main.async {
                    AppHelper.shared.hideProgressIndicator(view: self?.view)
                    self?.responseMsg.setupValue(value: error.localizedDescription, for: .error)
                }
            }
        }
        
    }
    
    func updateSliderImage(){
        
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
                self.updateSliderImage()
            }
            
        }
    }
    
    func callCountryPicker(){
        
        
        CountryPicker.show(
            from: self
//           , config: Config(
//                data: CustomizeCountryList(
//                    alterExisting: [
//                        .displayOnly(
//                            ["IN", "AU", "AE", "SA", "SG", "US"] //Enable to display selected country only
//                        )]
//                ))
        ){ result in
            switch result {
            case .success(let data):
                self.viewModel.data.countryCode = String(data.dial_code[data.dial_code.index(after: data.dial_code.startIndex)...])
                self.countryPickerBtn.setImage(data.emoji.emojToImage() ?? UIImage(), for: .normal)
            case .failure(let error):
                Log.error(error.localizedDescription)
            }
        }
    }
    
}

