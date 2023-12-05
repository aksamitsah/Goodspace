//
//  OtpVC.swift
//  Goodspace
//
//  Created by Amit Shah on 05/12/23.
//

import UIKit

class OtpVC: BaseVC {

    @IBOutlet weak private var headingLbl: UILabel!
    @IBOutlet weak private var responseMsg: UILabel!
    @IBOutlet weak private var resendBtn: UIButton!
    
    @IBOutlet weak private var otp001TF: UITextField!
    @IBOutlet weak private var otp002TF: UITextField!
    @IBOutlet weak private var otp003TF: UITextField!
    @IBOutlet weak private var otp004TF: UITextField!
    
    @IBOutlet weak private var otp001View: UIView!
    @IBOutlet weak private var otp002View: UIView!
    @IBOutlet weak private var otp003View: UIView!
    @IBOutlet weak private var otp004View: UIView!
    
    private let viewModel = OtpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        initilizeValue()
        resendOtpTimer()
        
    }
    
    @IBAction private func resendOTP(_ sender: UIButton) {
        
        if viewModel.counter != 0 { return }
        
        AppHelper.shared.showProgressIndicator(view: self.view)
        viewModel.resndOTP { [weak self] result in
            switch result{
            case .success(let data):
                    DispatchQueue.main.async {
                        AppHelper.shared.hideProgressIndicator(view: self?.view)
                        self?.responseMsg.setupValue(value: data, for: .default)
                        self?.resendOtpTimer()
                    }
            case .failure(let error):
                DispatchQueue.main.async {
                    AppHelper.shared.hideProgressIndicator(view: self?.view)
                    self?.responseMsg.setupValue(value: error.localizedDescription, for: .error)
                }
            }
        }
    }
    
    
    @IBAction private func closeBtn(_ sender: UIButton) {
        closeVC()
    }
    
    @IBAction private func editPhoneBtn(_ sender: UIButton) {
        
        EditPhoneNumberPopup.openVc(parentVC: self, data: viewModel.data) { new in
            self.data = new
            self.setupUI()
            self.initilizeValue()
            self.resendOtpTimer()
        }
    }
    
    @IBAction private func verifyOTP(_ sender: Any) {
        
        
        if !viewModel.isInvalidOTP,
           let otp001 = otp001TF.text, otp001.count == 1,
           let otp002 = otp002TF.text, otp002.count == 1,
           let otp003 = otp003TF.text, otp003.count == 1,
           let otp004 = otp004TF.text, otp004.count == 1 {
            
           verifyOTPObaserver(for: otp001 + otp002 + otp003 + otp004)
            
        }else{
            manageError(data: "Enter Correct OTP")
        }
        
    }
    
    
}

extension OtpVC {
    
    func resendOtpTimer(){
        viewModel.scheduleTimer { data in
            self.resendBtn.setTitle(data == 0 ? "Resend" : data < 10 ? "00:0\(data)" : "00:\(data)", for: .normal)
        }
    }
    
    private func verifyOTPObaserver(for otp: String){
        
        AppHelper.shared.showProgressIndicator(view: self.view)
        viewModel.VerifyOTP(otp: otp) { [weak self] result in
            switch result{
            case .success(_):
                    DispatchQueue.main.async {
                        AppHelper.shared.hideProgressIndicator(view: self?.view)
                        if AppSettings.isActiveUser{
                            self?.openVC(DashboardVC.self)
                        }
                    }
            case .failure(let error):
                DispatchQueue.main.async {
                    AppHelper.shared.hideProgressIndicator(view: self?.view)
                    self?.manageError(data: error.localizedDescription)
                }
            }
        }
    }
    
    private func manageError(data: String){
        
        viewModel.isInvalidOTP = true
        responseMsg.setupValue(value: data, for: .error)
        resendBtn.isHidden = true
        otp001View.updateOTPTheme(type: .error, textField: otp001TF)
        otp002View.updateOTPTheme(type: .error, textField: otp002TF)
        otp003View.updateOTPTheme(type: .error, textField: otp003TF)
        otp004View.updateOTPTheme(type: .error, textField: otp004TF)
    }
    
    private func setupUI(){
        
        (view.viewWithTag(201) as? UIButton)?.makeCircular()
        
        otp001TF.delegate = self
        otp002TF.delegate = self
        otp003TF.delegate = self
        otp004TF.delegate = self
        
        otp001View.updateOTPTheme()
        otp002View.updateOTPTheme()
        otp003View.updateOTPTheme()
        otp004View.updateOTPTheme()
        
        otp001TF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        otp002TF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        otp003TF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        otp004TF.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        
    }
    
    private func initilizeValue(){
        
        guard let user = data as? AuthModel else {
            closeVC()
            return
        }
        
        viewModel.data = user
        
        headingLbl.attributedText = NSAttributedString.coloredText(" OTP sent to +\(viewModel.data.countryCode) \(viewModel.data.mobile)\n Enter OTP to confirm your phone", color: UIColor.primaryColor, forSubstring: "\(viewModel.data.mobile)", font: UIFont(name: "Poppins-Medium", size: 20))
    }
    
}

extension OtpVC: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if viewModel.isInvalidOTP{
            viewModel.isInvalidOTP = false
            responseMsg.setupValue(value: "Didn't receive OTP?", for: .default)
            resendBtn.isHidden = false
            otp001View.updateOTPTheme(type: .fill, textField: otp001TF)
            otp002View.updateOTPTheme(type: .fill, textField: otp002TF)
            otp003View.updateOTPTheme(type: .fill, textField: otp003TF)
            otp004View.updateOTPTheme(type: .fill, textField: otp004TF)
        }
        return true
    }
    
    @objc private func textFieldDidChange(textField: UITextField){
             
         let text = textField.text
         
         if  text?.count == 1 {
                 switch textField{
                 case otp001TF:
                     otp001View.updateOTPTheme(type: .fill, textField: textField)
                     otp002TF.becomeFirstResponder()
                 case otp002TF:
                     otp002View.updateOTPTheme(type: .fill, textField: textField)
                     otp003TF.becomeFirstResponder()
                 case otp003TF:
                     otp003View.updateOTPTheme(type: .fill, textField: textField)
                     otp004TF.becomeFirstResponder()
                 case otp004TF:
                     otp004View.updateOTPTheme(type: .fill, textField: textField)
                     otp004TF.resignFirstResponder()
                 default:
                     break
                 }
             }
        
             else if text?.count == 0 {
                 switch textField{
                 case otp001TF:
                     otp001View.updateOTPTheme(type: .default, textField: textField)
                     otp001TF.becomeFirstResponder()
                 case otp002TF:
                     otp002View.updateOTPTheme(type: .default, textField: textField)
                     otp001TF.becomeFirstResponder()
                 case otp003TF:
                     otp003View.updateOTPTheme(type: .default, textField: textField)
                     otp002TF.becomeFirstResponder()
                 case otp004TF:
                     otp004View.updateOTPTheme(type: .default, textField: textField)
                     otp003TF.becomeFirstResponder()
                 default:
                     break
                 }
             }
         
        
         if  text!.count >= 2 {
             textField.text = ""
         }
     }

}


