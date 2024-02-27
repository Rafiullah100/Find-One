//
//  LoginViewController.swift
//  Find 1
//
//  Created by MacBook Pro on 2/7/24.
//

import UIKit
import AuthenticationServices
import GoogleSignIn
import Firebase
class LoginViewController: BaseViewController {
   
    @IBOutlet weak var keepMeButton: UIImageView!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var appleSigninView: UIView!

    private var viewModel = LoginViewModel()
    private let appleSignInButton = ASAuthorizationAppleIDButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text = "rafiullah@codeforpakistan.org"
        passwordTextField.text = "12345"
        viewModel.login.bind { [weak self] login in
            guard let self = self else{return}
            self.stopAnimation()
            if login?.user != nil{
                Switcher.gotoHome(delegate: self)
            }
            else{
                self.showAlert(message: login?.message ?? "")
            }
        }
        
        viewModel.appleLogin.bind { [weak self] appleLogin in
            guard let self = self else{return}
            self.stopAnimation()
            if appleLogin?.success == true{
                Switcher.gotoHome(delegate: self)
            }
            else{
                self.showAlert(message: appleLogin?.message ?? "")
            }
        }
        
        viewModel.googleLogin.bind { [weak self] googleLogin in
            guard let self = self else{return}
            self.stopAnimation()
            if googleLogin?.success == true{
                Switcher.gotoHome(delegate: self)
            }
            else{
                self.showAlert(message: googleLogin?.message ?? "")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        appleSigninView.addSubview(appleSignInButton)
        appleSignInButton.frame = CGRect(x: 0, y: 0, width: appleSigninView.frame.width, height: appleSigninView.frame.height)
        appleSignInButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    @objc func didTapButton(){
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.email, .fullName]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    @IBAction func loginBtnAction(_ sender: Any) {
        let login = LoginInputModel(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        print(login)
        let validationResponse = viewModel.isFormValid(user: login)
        if validationResponse.isValid {
            self.animateSpinner()
            viewModel.authenticateUser()
        }
        else{
            showAlert(message: validationResponse.message)
        }
    }
    
    @IBAction func googleSigninBtnAction(_ sender: Any) {
        let clientID = FirebaseApp.app()?.options.clientID
        guard let clientID = clientID else {
            return
        }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in
            guard error == nil else {
                return
            }
            if let result = result,
               let email = result.user.profile?.email,
               let name = result.user.profile?.name
               /*,let imageURL = result.user.profile?.imageURL(withDimension: 120)?.absoluteString*/ {
                print(email, name)
                self?.animateSpinner()
                self?.viewModel.googleLogin(email: email, name: name)
            }
        }
    }
    
    @IBAction func keepMeLogin(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        keepMeButton.image = sender.isSelected == true ? UIImage(named: "remember-me") : UIImage(named: "not-remember")
        UserDefaults.standard.rememberMe = sender.isSelected
    }
}

extension  LoginViewController: ASAuthorizationControllerDelegate{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("failed")
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let credential as ASAuthorizationAppleIDCredential:
            if let appleUser = AppleUserData(credentials: credential),
               let data = try? JSONEncoder().encode(appleUser) {
                do {
                    UserDefaults.standard.appleUserData = data
                    let email = credential.email ?? ""
                    let name = (credential.fullName?.givenName ?? "") + (credential.fullName?.familyName ?? "")
                    self.viewModel.appleLogin(email: email, name: name)
                }
            } else {
                print(credential.user)
                guard let data = UserDefaults.standard.appleUserData,
                      let appleUser = try? JSONDecoder().decode(AppleUserData.self, from: data)
                else { return }
                self.animateSpinner()
                self.viewModel.appleLogin(email: appleUser.email, name: "\(appleUser.firstName) \(appleUser.lastName)")
            }
        default:
            print("...")
        }
    }
}

extension  LoginViewController: ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
