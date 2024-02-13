//
//  HomeViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/12/24.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .home
        print("vnvev")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}
