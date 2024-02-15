//
//  BaseViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/12/24.
//

import UIKit
import SideMenu
enum ViewControllerType {
    case home
    case back
    case detail
}



class BaseViewController: UIViewController, UINavigationControllerDelegate {
    var isOverlayViewAdded: Bool = false
    var type: ViewControllerType = .home
    var titleLabel: UILabel?
    var overlayView: UIView?
    
    var viewControllerTitle: String? {
        didSet {
            titleLabel?.text = viewControllerTitle ?? ""
            switch type {
            case .home:
                setupHomeButtons()
            default:
                break
            }
        }
    }
    
    var actionBlock: (() -> Void)? = nil
    var isRefresh = false

    var task: URLSessionDataTask?
    var typeOfNews: String?


    func addCenterLabel() {
        titleLabel = UILabel()
        if let titleLabel = titleLabel {
            print(viewControllerTitle ?? "")
            titleLabel.text = viewControllerTitle ?? ""
            titleLabel.font = UIFont(name: Constants.fontNameBold, size: 17)
            titleLabel.textColor = .black
            self.navigationItem.titleView = titleLabel
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        solidNavigationBar(color: .clear)
        switch type {
        case .home:
            setupHomeButtons()
        case .back, .detail:
            setupDetailButtons()
        }
    }
    
    func solidNavigationBar(color: UIColor) {
        navigationController?.navigationBar.isTranslucent = true
       if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
           appearance.backgroundColor = color
           if type == .back{
               appearance.backgroundColor = CustomColor.appColor.color
           }
           else{
               appearance.backgroundColor = color
           }
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
           navigationController?.navigationBar.frame = CGRect(x: navigationController?.navigationBar.frame.origin.x ?? 0, y: navigationController?.navigationBar.frame.origin.y ?? 0, width: navigationController?.navigationBar.frame.width ?? 0, height: (navigationController?.navigationBar.frame.height ?? 0) )
           //y = 20
        }else{
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.backgroundColor = .clear
            navigationController?.navigationBar.frame = CGRect(x: navigationController?.navigationBar.frame.origin.x ?? 0, y: navigationController?.navigationBar.frame.origin.y ?? 0, width: navigationController?.navigationBar.frame.width ?? 0, height: (navigationController?.navigationBar.frame.height ?? 0) )
        }
        
        
    }
    
    func setupHomeBarButtonItems() {
        navigationItem.leftBarButtonItems = []
        navigationItem.rightBarButtonItems = []
    }
    
    func setupBackButtonWithTitle() {
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = []
        addBackButtonWithTitle()
    }
    
    func addBackButtonWithTitle() {
        let leftButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonAction))
        leftButton.image = UIImage(named: "")
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = leftButton
    }
    
    
    func setupHomeButtons() {
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = []
        addHomeButtons()
//        addCenterLabel()
    }
    
    func setupDetailButtons() {
        navigationItem.rightBarButtonItems = []
        navigationItem.leftBarButtonItems = []
        addDetailButtons()
    }
    
    func addDetailButtons(isWhite: Bool = true) {
        let leftButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonAction))
        leftButton.image = type == .back ? UIImage(named: "back") : UIImage(named: "detail-back")
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = leftButton
    }

    
    func addArrowBackButton() {
        let backButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonAction))
        backButton.image = nil
        backButton.image = UIImage(named: "")
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func addHomeButtons() {
        let sideMenuButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(menuButtonAction))
        let searchButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(filterAction))
        searchButton.image = UIImage(named: "search")
        sideMenuButton.image = UIImage(named: "side-menu-icon")
        self.navigationController?.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = sideMenuButton
        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    @objc func menuButtonAction(){
        let menu = UIStoryboard(name: Storyboard.menu.rawValue, bundle: nil).instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController

        menu.delegate = self
//        menu.leftSide = Helper.shared.semantic(AppLanguage(rawValue: UserDefaults.standard.selectedLanguage ?? "") ?? .english) == .forceRightToLeft ? false : true

        menu.menuWidth = self.view.frame.size.width * 0.80
        present(menu, animated: true, completion: nil)
    }
    
//    func addDetailButtons(isWhite: Bool = true) {
//        let leftButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(backButtonAction))
//        let rightButton = UIBarButtonItem(title: LocalizationKeys.viewSource.rawValue.localizeString(), style: .plain, target: self, action: #selector(sourceButtonAction))
//        rightButton.tintColor = .white
//        if isWhite == true {
//            leftButton.image = Helper.shared.isRTL() ? UIImage(named: "white-arrow-back-rtl") : UIImage(named: "white-arrow-back")
//        }
//        else{
//            leftButton.image = Helper.shared.isRTL() ? UIImage(named: "back-arrow-rtl") : UIImage(named: "back-arrow")
//        }
//        self.navigationController?.navigationItem.hidesBackButton = true
//        self.navigationItem.leftBarButtonItem = leftButton
////        self.navigationItem.rightBarButtonItem = rightButton
//    }
    
    @objc func sourceButtonAction(){
        actionBlock?()
    }
    
    func homeButtons() {
        let filterButton = UIButton()
        filterButton.setImage(UIImage(named: "filter"), for: .normal)
        filterButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let shareItem = UIBarButtonItem()
        filterButton.addTarget(self, action: #selector(filterAction), for: .touchUpInside)
        shareItem.customView = filterButton

        let likeButton = UIButton()
        likeButton.setImage(UIImage(named: "fav"), for: .normal)
        likeButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let likeItem = UIBarButtonItem()
        likeItem.customView = likeButton
        self.navigationItem.rightBarButtonItems = [shareItem, likeItem]
    }
    
    @objc func backButtonAction() {
        print(isRefresh)
        if isRefresh == true{
//            Switcher.gotoHome(delegate: self)
        }
        else{
            if let _ = navigationController?.popViewController(animated: true) {
            } else {
                navigationController?.tabBarController?.selectedIndex = 0
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc func filterAction() {
//        searchView.isHidden.toggle()
//        titleLabel?.isHidden.toggle()
//
//        if self.navigationItem.titleView == searchView{
//            textField?.resignFirstResponder()
//            self.navigationItem.titleView = titleLabel
//        }
//        else{
//            textField?.becomeFirstResponder()
//            self.navigationItem.titleView = searchView
//        }
    }
    
    @objc func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func backAction() {
        if let _ = navigationController?.popViewController(animated: true) {
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
//    @objc func textFieldDidChange(_ textField: UITextField) {
//        guard let text = textField.text, !text.isEmpty else {
//            self.textField?.filterStrings([])
//            return  }
//        task?.cancel()
//        if typeOfNews == Constants.news{
//            newsSearch(text: text)
//        }
//        else{
//            opinionSearch(text: text)
//        }
//    }
//
//    private func newsSearch(text: String){
//        let parameters = ["q": text, "index": typeOfNews ?? "news"] as [String : Any]
//       task = URLSession.shared.request(route: .search, method: .get, parameters: parameters, model: searchNewsModel.self) { result in
//            switch result {
//            case .success(let search):
//                if let searchDataArray = search.data {
//                    self.searchNewsArray = []
//                    self.textField?.filterStrings([])
//                    self.searchNewsArray = searchDataArray
//                    let titlesArray = searchDataArray.map { $0.source?.title ?? ""}
//                    self.textField?.filterStrings(titlesArray)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
    
//    private func opinionSearch(text: String){
//        let parameters = ["q": text, "index": typeOfNews ?? "opinion"] as [String : Any]
//        print(parameters)
//       task = URLSession.shared.request(route: .search, method: .get, parameters: parameters, model: SearchOpinionModel.self) { result in
//            switch result {
//            case .success(let search):
//                if let searchDataArray = search.data {
//                    self.searchOpinionArray = searchDataArray
//                    let titlesArray = searchDataArray.map { $0.source?.title ?? "" }
//                    self.textField?.filterStrings(titlesArray)
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
}

extension BaseViewController: SideMenuNavigationControllerDelegate{
    func sideMenuWillAppear(menu: SideMenuNavigationController, animated: Bool) {
        if !isOverlayViewAdded {
            self.overlayView = UIView(frame: self.view.bounds)
            self.overlayView?.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            self.view.addSubview(self.overlayView!)
            isOverlayViewAdded = true
        }
    }
       
    func sideMenuWillDisappear(menu: SideMenuNavigationController, animated: Bool) {
        print(isOverlayViewAdded)
        if isOverlayViewAdded == true {
            self.overlayView?.removeFromSuperview()
            self.overlayView = nil
            isOverlayViewAdded = false
        }
    }
}


