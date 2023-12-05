//
//  EditPhoneNumberPopup.swift
//  Goodspace
//
//  Created by Amit Shah on 05/12/23.
//

import UIKit
import CountryPickerAKS

class EditPhoneNumberPopup: BaseVC {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var responseMsg: UILabel!
    @IBOutlet weak private var dividerView: UIView!
    @IBOutlet weak private var bottomView: UIView!
    @IBOutlet weak private var countryPickerBtn: UIButton!
    @IBOutlet weak private var mobileNoTF: UITextField!
    
    var completion: ((AuthModel) -> Void)?
    
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        initilizeValue()
        
    }
    
    @IBAction private func onTapGetOTP(_ sender: UIButton) {
        
        mobileNoTF.resignFirstResponder()
        
        if !checkValidation(textField: mobileNoTF){
            return
        }
        
        dataObserver()
        
    }
    
    @IBAction private func countryPicker(_ sender: UIButton) {
        callCountryPicker()
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    static func openVc(parentVC: UIViewController, data: AuthModel, completion: @escaping (AuthModel) -> Void){
        
          let vc = EditPhoneNumberPopup(nibName: "EditPhoneNumberPopup", bundle: Bundle.main)
          vc.modalPresentationStyle = .custom
          vc.modalTransitionStyle = .crossDissolve
          vc.viewModel.data = data
          vc.completion = completion
          parentVC.present(vc, animated: true)
    }

}

extension EditPhoneNumberPopup: UITextFieldDelegate{
    
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


extension EditPhoneNumberPopup{
    
    private func setupUI(){
        
        mobileNoTF.addDoneButtonOnKeyboard()
        
        mobileNoTF.delegate = self
        
        bottomView.updateTheme()
        
        mainView.layer.cornerRadius = 10
        (view.viewWithTag(201) as? UIButton)?.makeCircular()
        
        view.backgroundColor = .black.withAlphaComponent(0.5)
        
    }
    
    private func initilizeValue(){
        
        countryPickerBtn.setTitle(" ", for: .normal)
        mobileNoTF.text = viewModel.data.mobile
        countryPickerBtn.setImage(viewModel.data.countryFlag ?? UIImage(), for: .normal)
        
    }
    
    private func checkValidation(textField: UITextField) -> Bool{
        
        if let text = textField.text, !text.isEmpty{
            
            let validation = Validation.isValidNumber(phoneNumber: text)
            
            if validation {
                responseMsg.setupValue(value: "Please be sure to select the correct area code and enter 10 digits.", for: .clear)
                bottomView.updateTheme(type: .clear, textField: mobileNoTF, view2: dividerView)
            } else {
                responseMsg.setupValue(value: "Enter Correct phone number", for: .error)
                bottomView.updateTheme(type: .error, textField: mobileNoTF, view2: dividerView)
            }
            
            return validation
            
        }else {
            responseMsg.setupValue(value: "Please be sure to select the correct area code and enter 10 digits.", for: .clear)
            bottomView.updateTheme(type: .clear, textField: mobileNoTF, view2: dividerView)
            
            return false
        }
    }
    
    private func returnWithValue(){
        
        dismiss(animated: true, completion: {
            self.completion?(self.viewModel.data)
        })
    }
    
    private func dataObserver(){
        AppHelper.shared.showProgressIndicator(view: self.view)
        viewModel.getOTP(mobile: mobileNoTF.text ?? "") { [weak self] result in
            switch result{
            case .success(let data):
                    DispatchQueue.main.async {
                        AppHelper.shared.hideProgressIndicator(view: self?.view)
                        self?.responseMsg.setupValue(value: data, for: .clear)
                        self?.returnWithValue()
                    }
            case .failure(let error):
                DispatchQueue.main.async {
                    AppHelper.shared.hideProgressIndicator(view: self?.view)
                    self?.responseMsg.setupValue(value: error.localizedDescription, for: .error)
                }
            }
        }
        
    }
    
    private func callCountryPicker(){
        
        CountryPicker.show(
            from: self
        ){ result in
            switch result {
            case .success(let data):
                self.viewModel.data.countryCode = String(data.dial_code[data.dial_code.index(after: data.dial_code.startIndex)...])
                self.viewModel.data.countryFlag = data.emoji.emojToImage()
                self.countryPickerBtn.setImage(data.emoji.emojToImage() ?? UIImage(), for: .normal)
            case .failure(let error):
                Log.error(error.localizedDescription)
            }
        }
        
    }
    
}
