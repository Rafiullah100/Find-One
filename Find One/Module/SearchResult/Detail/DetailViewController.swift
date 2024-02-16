//
//  DetailViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/15/24.
//

import UIKit

class DetailViewController: BaseViewController {

    lazy var browseVC: FeeStructureViewController = {
        return UIStoryboard(name: Storyboard.result.rawValue, bundle: nil).instantiateViewController(withIdentifier: "FeeStructureViewController") as! FeeStructureViewController
    }()
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var pageControl: CustomPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .detail
        addChildVC()
        custompageContrl()
    }
    
    private func addChildVC(){
        addChild(browseVC)
        self.add(browseVC, in: contentView)
        browseVC.view.frame = contentView.bounds
        contentView.addSubview(browseVC.view)
        browseVC.didMove(toParent: self)
    }

    private func custompageContrl(){
        pageControl.inactiveImage = UIImage(named: "ellipse")
        pageControl.activeImage = UIImage(named: "ellipse")
        pageControl.numberOfPages = 5
        pageControl.currentPage = 2
//        pageControl.transform = Helper.shared.isRTL() == true ? view.transform.rotated(by: .pi) : view.transform.rotated(by: 0)
    }
}
