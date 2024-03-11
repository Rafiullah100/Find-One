//
//  StudentBookingViewController.swift
//  Find One
//
//  Created by MacBook Pro on 3/11/24.
//

import UIKit

class StudentBookingViewController: BaseViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
    }

}
