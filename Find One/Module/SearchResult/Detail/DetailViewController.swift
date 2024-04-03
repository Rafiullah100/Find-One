//
//  DetailViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/15/24.
//

import UIKit

class DetailViewController: BaseViewController {

    @IBOutlet weak var sliderLabel: UILabel!
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    //    lazy var browseVC: BrowseViewController = {
//        return UIStoryboard(name: Storyboard.result.rawValue, bundle: nil).instantiateViewController(withIdentifier: "BrowseViewController") as! BrowseViewController
//    }()
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
    lazy var sustainableVC: SustainableViewController = {
        return UIStoryboard(name: Storyboard.result.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SustainableViewController") as! SustainableViewController
    }()
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var pageControl: CustomPageControl!
    
    @IBOutlet weak var galleryCollectionView: UICollectionView!{
        didSet{
            galleryCollectionView.dataSource = self
            galleryCollectionView.delegate = self
            galleryCollectionView.register(UINib(nibName: "SliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: SliderCollectionViewCell.cellReuseIdentifier())
        }
    }
    var childVC: UIViewController!
    var id: Int?
    var slug: String?

    var viewModel = DetailViewModel()
    var details: DetailModel?
    var autoScrollTimer: Timer?
    var currentPage = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .detail
        informationVC.delegate = self
        childVC = informationVC
        addChildVC()

        viewModel.details.bind { detail in
            DispatchQueue.main.async {
                guard let detail = detail else{return}
                self.stopAnimation()
                self.details = detail
                self.reloadView()
                self.galleryCollectionView.reloadData()
                self.custompageContrl()
                self.setupAutoScroll()
            }
        }
        self.animateSpinner()
        viewModel.getInstituteDetails(id: id ?? 0, slug: slug ?? "")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        topViewHeight.constant = Helper.cellSize(ipad: 500.0, iphone: 300.0)
    }
    
    private func addChildVC(){
        addChild(childVC)
        self.add(childVC, in: contentView)
        childVC.view.frame = contentView.bounds
        contentView.addSubview(childVC.view)
        childVC.didMove(toParent: self)
    }

    private func custompageContrl(){
        pageControl.numberOfPages = details?.result?.instituteGallery?.count ?? 0
        pageControl.currentPage = currentPage
        pageControl.inactiveImage = UIImage(named: "dot")
        pageControl.activeImage = UIImage(named: "ellipse")
    }
    
    override func backButtonAction() {
        if isChildViewControllerAdded(informationVC) == true{
            super.backButtonAction()
        }
        else{
            removeChild(childVC: childVC)
            childVC = informationVC
            addChildVC()
        }
    }
    
    func setupAutoScroll() {
        self.autoScrollTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(self.autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc func autoScroll() {
        guard details?.result?.instituteGallery?.count ?? 0 > 0 else {
            return
        }
        let nextPage = (currentPage + 1) % (details?.result?.instituteGallery?.count ?? 0)
        let indexPath = IndexPath(item: nextPage, section: 0)
        galleryCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        currentPage = nextPage
        pageControl.currentPage = currentPage
        pageControl.setNeedsDisplay()
        print(currentPage)
        sliderLabel.text = "\(currentPage + 1)  / \(details?.result?.instituteGallery?.count ?? 0)"
    }
    
    private func reloadView(){
        nameLabel.text = details?.result?.name?.trimmingCharacters(in: .whitespacesAndNewlines)
        addressLabel.text = details?.result?.address?.trimmingCharacters(in: .whitespacesAndNewlines)
        informationVC.information = self.details?.result
        ratingLabel.text = details?.result?.reviewsAvg
    }
}

extension DetailViewController: BrowseDelegate{
    func selectCategory(index: Int) {
        removeChild(childVC: informationVC)
        switch index {
        case 0:
            childVC = sustainableVC
        case 1:
            childVC = feeVC
            feeVC.id = id
        case 2:
            childVC = galleryVC
            galleryVC.id = id
        case 3:
            childVC = reviewVC
            reviewVC.id = id
        case 4:
            Switcher.gotoLocation(delegate: self, id: id ?? 0)
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

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return details?.result?.instituteGallery?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SliderCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: SliderCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! SliderCollectionViewCell
        cell.gallery = details?.result?.instituteGallery?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
