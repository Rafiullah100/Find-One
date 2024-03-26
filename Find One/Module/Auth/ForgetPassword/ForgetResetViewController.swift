//
//  ForgetResetViewController.swift
//  Find One
//
//  Created by MacBook Pro on 3/25/24.
//

import UIKit
import OTPFieldView
class ForgetResetViewController: BaseViewController {

    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var otpField: OTPFieldView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    
    var email: String?
    var otp: String?
//    var viewModel = PasswordResetViewModel()
    var otpSeparatorSpace = 8.0
    var fieldsCount = 4
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        type = .back
        viewControllerTitle = "Change Password"
        updateUI()
        setupOtpView()
    }
    
    private func updateUI(){
        messageLabel.text = "OTP code sent to your email: \(email ?? "")"
        newPasswordTextField.placeholder = LocalizationKeys.newPassword.rawValue.localizeString()
        confirmTextField.placeholder = LocalizationKeys.confirmPassword.rawValue.localizeString()
        resetButton.setTitle(LocalizationKeys.reset.rawValue.localizeString(), for: .normal)
        newPasswordTextField.textAlignment = Helper.isRTL() ? .right : .left
        confirmTextField.textAlignment = Helper.isRTL() ? .right : .left
    }
    
    func setupOtpView(){
        self.otpField.fieldsCount = fieldsCount
        self.otpField.fieldBorderWidth = 2
        self.otpField.defaultBorderColor = CustomColor.appColor.color
        self.otpField.filledBorderColor = CustomColor.appColor.color
        self.otpField.cursorColor = UIColor.black
        self.otpField.displayType = .circular
        self.otpField.fieldSize = 50
        self.otpField.separatorSpace = otpSeparatorSpace
        self.otpField.shouldAllowIntermediateEditing = false
        self.otpField.delegate = self
        self.otpField.initializeUI()
    }
    
    @IBAction func resetBtnAction(_ sender: Any) {
//        let reset = ResetInputModel(email: email ?? "", password: newPasswordTextField.text ?? "", confirmPassword: confirmTextField.text ?? "", otp: otp ?? "")
//        let isValid = viewModel.isFormValid(user: reset)
//        if isValid {
//            self.resetPassword()
//        }
//        else{
//            showAlert(message: "Please fill all fields and try again!")
//        }
    }
    
    
    private func resetPassword(){
//        self.animateSpinner()
//        viewModel.resetUserPassword { result in
//            self.stopAnimation()
//            switch result {
//            case .success(let response):
//                if response.success == true{
//                    Switcher.gotoLogin(delegate: self)
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

extension ForgetResetViewController: OTPFieldViewDelegate {
    func hasEnteredAllOTP(hasEnteredAll hasEntered: Bool) -> Bool {
        print("Has entered all OTP? \(hasEntered)")
        return false
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp otpString: String) {
        otp = otpString
    }
}
