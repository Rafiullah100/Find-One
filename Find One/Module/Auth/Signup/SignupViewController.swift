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
    
    private var viewModel = SignupViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
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
}
