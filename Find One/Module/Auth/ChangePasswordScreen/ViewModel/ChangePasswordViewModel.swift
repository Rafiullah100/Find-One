//
//  ChangePasswordViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/20/23.
//

import Foundation


class ChangePasswordViewModel {
    var errorMessage: Observable<String> = Observable("")
    var changePassword: Observable<ChangePasswordModel> = Observable(nil)

    var parameters: [String: Any]?
    
    func isFormValid(changePassword: ChangePasswordInputModel) -> ValidationResponse {
        if changePassword.password.isEmpty || changePassword.confrimpassword.isEmpty || changePassword.oldPassword.isEmpty{
            return ValidationResponse(isValid: false, message: "Please fill all field and try again!")
        }
        else if changePassword.password != changePassword.confrimpassword{
            return ValidationResponse(isValid: false, message: "Password doesn't match!")
        }
        else{
            parameters = ["old_password": changePassword.oldPassword, "confirm_password": changePassword.confrimpassword, "password": changePassword.password]
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
    func updatePassword(){
        URLSession.shared.request(route: .changePassword, method: .post, parameters: parameters, model: ChangePasswordModel.self) { result in
            switch result {
            case .success(let change):
                self.changePassword.value = change
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}
