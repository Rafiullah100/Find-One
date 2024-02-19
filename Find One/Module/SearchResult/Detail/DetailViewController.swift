//
//  DetailViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/15/24.
//

import UIKit

class DetailViewController: BaseViewController {

    lazy var browseVC: BrowseViewController = {
        return UIStoryboard(name: Storyboard.result.rawValue, bundle: nil).instantiateViewController(withIdentifier: "BrowseViewController") as! BrowseViewController
    }()
    lazy var informationVC: InformationViewController = {
        return UIStoryboard(name: Storyboard.result.rawValue, bundle: nil).instantiateViewController(withIdentifier: "InformationViewController") as! InformationViewController
    }()
    lazy var feeVC: FeeStructureViewController = {
        return UIStoryboard(name: Storyboard.result.rawValue, bundle: nil).instantiateViewController(withIdentifier: "FeeStructureViewController") as! FeeStructureViewController
    }()
    lazy var galleryVC: GalleryViewController = {
        return UIStoryboard(name: Storyboard.result.rawValue, bundle: nil).instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
    }()
    lazy var reviewVC: ReviewViewController = {
        return UIStoryboard(name: Storyboard.result.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ReviewViewController") as! ReviewViewController
    }()
    lazy var locationVC: LocationViewController = {
        return UIStoryboard(name: Storyboard.result.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
    }()
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var pageControl: CustomPageControl!
    
    var childVC: UIViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .detail
        browseVC.delegate = self
        childVC = browseVC
        addChildVC()
        custompageContrl()
    }
    
    private func addChildVC(){
        addChild(childVC)
        self.add(childVC, in: contentView)
        childVC.view.frame = contentView.bounds
        contentView.addSubview(childVC.view)
        childVC.didMove(toParent: self)
    }

    private func custompageContrl(){
        pageControl.inactiveImage = UIImage(named: "dot")
        pageControl.activeImage = UIImage(named: "ellipse")
        pageControl.numberOfPages = 6
        pageControl.currentPage = 0
    }
    
    override func backButtonAction() {
        if isChildViewControllerAdded(browseVC) == true{
            super.backButtonAction()
        }
        else{
            removeChild(childVC: childVC)
            childVC = browseVC
            addChildVC()
        }
    }
}

extension DetailViewController: BrowseDelegate{
    func selectCategory(index: Int) {
        removeChild(childVC: browseVC)
        switch index {
        case 0:
            childVC = informationVC
        case 1:
            print("erkfm")
        case 2:
            childVC = feeVC
        case 3:
            childVC = galleryVC
        case 4:
            childVC = reviewVC
        case 5:
            childVC = locationVC
        default:
            break
        }
        addChildVC()
    }
    
    func isChildViewControllerAdded(_ childViewController: UIViewController) -> Bool {
        for childVC in self.children {
            if childVC === childViewController {
                return true
            }
        }
        return false
    }
}
