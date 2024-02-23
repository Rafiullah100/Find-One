//
//  LoginViewModel.swift
//  Find One
//
//  Created by MacBook Pro on 2/23/24.
//

import Foundation
import AuthenticationServices

struct AppleUserData: Codable {
    let userID: String
    let firstName: String
    let lastName: String
    let email: String
    
    init?(credentials: ASAuthorizationAppleIDCredential) {
        guard let firstName = credentials.fullName?.givenName,
              let lastName = credentials.fullName?.familyName,
              let email = credentials.email
        else { return nil }
        self.userID = credentials.user
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}

class LoginViewModel {
    var login: Observable<LoginModel> = Observable(nil)
    var errorMessage: Observable<String> = Observable("")
    var isAuthenticationInProgress: Bool = false
    var loginData: LoginModel?
    
    var appleLogin: Observable<AppleLoginModel> = Observable(nil)
    var appleLoginData: AppleLoginModel?

    var parameters: [String: Any]?
    
    func isFormValid(user: LoginInputModel) -> ValidationResponse {
        if user.email.isEmpty || user.password.isEmpty {
            return ValidationResponse(isValid: false, message: "Please fill all field and try again!")
        }
        else if !Helper.isValidEmail(email: user.email){
            return ValidationResponse(isValid: false, message: "Please enter a valid email!")
        }
        else{
            parameters = ["username": user.email, "password": user.password]
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
    func authenticateUser(){
        URLSession.shared.request(route: .login, method: .post, parameters: parameters, model: LoginModel.self) { result in
            switch result {
            case .success(let login):
                self.login.value = login
                self.saveUserPreference()
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func saveUserPreference(){
        UserDefaults.standard.name = self.loginData?.user?.name
        UserDefaults.standard.email = self.loginData?.user?.email
        UserDefaults.standard.profileImage = self.loginData?.user?.profileImage
        UserDefaults.standard.token = self.loginData?.user?.token
        UserDefaults.standard.mobile = self.loginData?.user?.mobileNo
        UserDefaults.standard.uuid = self.loginData?.user?.uuid
        UserDefaults.standard.isLogin = true
    }
    
    func appleLogin(email: String, name: String) {
        print(email, name)
        URLSession.shared.request(route: .appleLogin, method: .post, parameters: ["email": email, "name": name], model: AppleLoginModel.self) { result in
            switch result {
            case .success(let appleLogin):
                self.appleLoginData = appleLogin
                self.appleLogin.value = appleLogin
                self.saveAppleUserPreference()
                
        case .failure(let error):
            self.errorMessage.value = error.localizedDescription
        }
    }
}
    
    func saveAppleUserPreference(){
        UserDefaults.standard.name = self.appleLoginData?.name
        UserDefaults.standard.email = self.appleLoginData?.email
        UserDefaults.standard.profileImage = self.appleLoginData?.profileImage
        UserDefaults.standard.token = self.appleLoginData?.token
        UserDefaults.standard.mobile = self.appleLoginData?.mobileNo
        UserDefaults.standard.uuid = self.appleLoginData?.uuID
        UserDefaults.standard.isLogin = true
    }
}
