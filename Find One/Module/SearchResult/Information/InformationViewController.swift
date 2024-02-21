//
//  InformationViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/16/24.
//

import UIKit

class InformationViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 35, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.backgroundColor = .clear
    }

}
