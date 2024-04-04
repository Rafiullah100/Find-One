//
//  ForgotPasswordViewController.swift
//  Find One
//
//  Created by MacBook Pro on 3/25/24.
//

import UIKit

class ForgotPasswordViewController: BaseViewController {

    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    
//    let viewModel = ForgotPasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back
        
        emailTextField.textAlignment = Helper.isRTL() == true ? .right : .left
        emailTextField.placeholder = LocalizationKeys.email.rawValue.localizeString()
        sendButton.setTitle(LocalizationKeys.send.rawValue.localizeString(), for: .normal)
        viewControllerTitle = LocalizationKeys.forgetPassword.rawValue.localizeString()
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func updateUI(){
//        emailTextField.placeholder = LocalizationKeys.email.rawValue.localizeString()
//        sendButton.setTitle(LocalizationKeys.send.rawValue.localizeString(), for: .normal)
//        emailTextField.textAlignment = Helper.shared.isRTL() ? .right : .left
    }
    
    @IBAction func sendBtnAction(_ sender: Any) {
//        let isValid = viewModel.isFormValid(email: emailTextField.text ?? "")
//        print(isValid)
//        if isValid {
//            self.forgotPassword()
//        }
//        else{
//            showAlert(message: "Please fill all fields and try again!")
//        }
    }
    
    private func forgotPassword(){
//        self.animateSpinner()
//        viewModel.loginUser { result in
//            self.stopAnimation()
//            switch result {
//            case .success(let response):
//                if response.success == true{
//                    Switcher.gotoResetPassword(delegate: self, email: self.emailTextField.text ?? "")
//                }
//                else{
//                    self.showAlert(message: response.message)
//                }
//            case .failure(let error):
//                self.showAlert(message: error.localizedDescription)
//            }
//        }
    }
}
