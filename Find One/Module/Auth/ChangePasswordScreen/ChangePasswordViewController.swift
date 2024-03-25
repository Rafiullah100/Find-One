//
//  ChangePasswordViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/20/23.
//

import UIKit

class ChangePasswordViewController: BaseViewController {

    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var currentPasswordTextField: UITextField!
    
    let viewModel = ChangePasswordViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confirmTextField.textAlignment = Helper.isRTL() ? .right : .left
        newPasswordTextField.textAlignment = Helper.isRTL() ? .right : .left
        currentPasswordTextField.textAlignment = Helper.isRTL() ? .right : .left

        confirmTextField.placeholder = LocalizationKeys.confirmPassword.rawValue.localizeString()
        newPasswordTextField.placeholder = LocalizationKeys.newPassword.rawValue.localizeString()
        currentPasswordTextField.placeholder = LocalizationKeys.currentPassword.rawValue.localizeString()
        updateButton.setTitle(LocalizationKeys.updatePassword.rawValue.localizeString(), for: .normal)

        
        type = .detail
        viewControllerTitle = "Update Password"
        viewModel.changePassword.bind { [unowned self] update in
            self.stopAnimation()
            showAlert(message: update?.message ?? "")
        }
    }

    @IBAction func updateBtnAction(_ sender: Any) {
        let change = ChangePasswordInputModel(oldPassword: currentPasswordTextField.text ?? "" , password: newPasswordTextField.text ?? "", confrimpassword: confirmTextField.text ?? "")
        print(change)
        let validationResponse = viewModel.isFormValid(changePassword: change)
        if validationResponse.isValid {
            self.animateSpinner()
            viewModel.updatePassword()
        }
        else{
            showAlert(message: validationResponse.message)
        }
    }
}
