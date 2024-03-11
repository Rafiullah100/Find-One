//
//  ParentBookingViewController.swift
//  Find One
//
//  Created by MacBook Pro on 3/11/24.
//

import UIKit

protocol ChildViewControllerDelegate: AnyObject {
    func addButtonTapped()
}

class ParentBookingViewController: BaseViewController {
    weak var delegate: ChildViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back
    }
    
    
    @IBAction func nextBtnAction(_ sender: Any) {
        delegate?.addButtonTapped()
    }
}
