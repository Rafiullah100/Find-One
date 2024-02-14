//
//  CustomSearchViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/13/24.
//

import UIKit

class CustomSearchViewController: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .home
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
    }
}
