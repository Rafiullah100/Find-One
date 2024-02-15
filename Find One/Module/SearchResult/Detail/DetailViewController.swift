//
//  DetailViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/15/24.
//

import UIKit

class DetailViewController: BaseViewController {

    @IBOutlet weak var pageControl: CustomPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .detail
        
        custompageContrl()
    }

    private func custompageContrl(){
        pageControl.inactiveImage = UIImage(named: "ellipse")
        pageControl.activeImage = UIImage(named: "ellipse")
        pageControl.numberOfPages = 5
        pageControl.currentPage = 2
//        pageControl.transform = Helper.shared.isRTL() == true ? view.transform.rotated(by: .pi) : view.transform.rotated(by: 0)
    }
}
