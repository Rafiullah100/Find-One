//
//  SignupViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/12/24.
//

import UIKit

class SignupViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func loginBtnAction(_ sender: Any) {
        Switcher.gotoHome(delegate: self)
    }
}
