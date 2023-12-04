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

extension BaseVC{
    
    func isSlideKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
}


//extension UITextField {
//
//   func addDoneButtonOnKeyboard() {
//       let keyboardToolbar = UIToolbar()
//       keyboardToolbar.sizeToFit()
//       let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
//           target: nil, action: nil)
//       let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
//           target: self, action: #selector(resignFirstResponder))
//       keyboardToolbar.items = [flexibleSpace, doneButton]
//       self.inputAccessoryView = keyboardToolbar
//   }
//}


extension UITextField{
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }

    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        self.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
    }
}
