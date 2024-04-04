//
//  SignupViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/12/24.
//

import UIKit

class SignupViewController: BaseViewController {
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var alreadyLabel: UILabel!
    private var viewModel = SignupViewModel()
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var languageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.textAlignment = Helper.isRTL() ? .right : .left
        emailTextField.textAlignment = Helper.isRTL() ? .right : .left
        mobileTextField.textAlignment = Helper.isRTL() ? .right : .left
        passwordTextfield.textAlignment = Helper.isRTL() ? .right : .left
        confirmTextField.textAlignment = Helper.isRTL() ? .right : .left

        languageLabel.text = LocalizationKeys.selectedLanguage.rawValue.localizeString()

        nameTextField.placeholder = LocalizationKeys.name.rawValue.localizeString()
        emailTextField.placeholder = LocalizationKeys.email.rawValue.localizeString()
        mobileTextField.placeholder = LocalizationKeys.contactNumber.rawValue.localizeString()
        passwordTextfield.placeholder = LocalizationKeys.password.rawValue.localizeString()
        confirmTextField.placeholder = LocalizationKeys.confirmPassword.rawValue.localizeString()
        alreadyLabel.text = LocalizationKeys.alreadyAccount.rawValue.localizeString()
        loginButton.setTitle(LocalizationKeys.login.rawValue.localizeString(), for: .normal)
        getStartedButton.setTitle(LocalizationKeys.getStarted.rawValue.localizeString(), for: .normal)

        nameTextField.text = "Rafiullah"
        emailTextField.text = "rafiullah@gmail.com"
        mobileTextField.text = "04037867876"
        passwordTextfield.text = "123"
        confirmTextField.text = "123"

        viewModel.signup.bind { [unowned self] signup in
            self.stopAnimation()
            if signup?.success == true{
                Switcher.gotoLogin(delegate: self)
            }
            else{
                showAlert(message: signup?.message ?? "")
            }
        }
    }

   
    @IBAction func getStarted(_ sender: Any) {
        let signup = SignupInputModel(name: nameTextField.text ?? "", email: emailTextField.text ?? "", password: passwordTextfield.text ?? "", confirmPassword: confirmTextField.text ?? "", mobile: mobileTextField.text ?? "")
        let validationResponse = viewModel.isFormValid(user: signup)
        if validationResponse.isValid {
            self.animateSpinner()
            self.viewModel.signupUser()
        }
        else{
            showAlert(message: validationResponse.message)
        }
    }
    
    @IBAction func languageBtnAction(_ sender: Any) {
        if UserDefaults.standard.selectedLanguage == AppLanguage.arabic.rawValue {
            UserDefaults.standard.selectedLanguage = AppLanguage.english.rawValue
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        else{
            UserDefaults.standard.selectedLanguage = AppLanguage.arabic.rawValue
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        Switcher.refreshSignupView(delegate: self)
    }
}
