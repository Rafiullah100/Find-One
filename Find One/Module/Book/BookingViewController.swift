//
//  BookingViewController.swift
//  Find One
//
//  Created by MacBook Pro on 3/11/24.
//

import UIKit

class BookingViewController: BaseViewController, ChildViewControllerDelegate {
    func addButtonTapped() {
        addChildVC(childVC: studentVC)
    }
    

    @IBOutlet weak var containerView: UIView!
    lazy var parentVC: ParentBookingViewController = {
        return UIStoryboard(name: Storyboard.booking.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ParentBookingViewController") as! ParentBookingViewController
    }()
    lazy var studentVC: StudentBookingViewController = {
        return UIStoryboard(name: Storyboard.booking.rawValue, bundle: nil).instantiateViewController(withIdentifier: "StudentBookingViewController") as! StudentBookingViewController
    }()
    var childVC: UIViewController!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back
        addChildVC(childVC: parentVC)
    }

    private func addChildVC(childVC: UIViewController){
        parentVC.delegate = self

        addChild(childVC)
        self.add(childVC, in: containerView)
        childVC.view.frame = containerView.bounds
        containerView.addSubview(childVC.view)
        childVC.didMove(toParent: self)
    }
}
