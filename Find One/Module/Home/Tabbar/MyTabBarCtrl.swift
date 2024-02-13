//
//  MyTabBarCtrl.swift
//  Find One
//
//  Created by MacBook Pro on 2/13/24.
//

import UIKit
import SwiftIcons

class MyTabBarCtrl: UITabBarController, UITabBarControllerDelegate {
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: CustomColor.appColor.color], for: .selected)
        setupMiddleButton()
   }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupMiddleButton() {
        
        let middleBtn = UIButton(frame: CGRect(x: (self.view.bounds.width / 2) - 30, y: -35, width: 60, height: 60))
        
        //STYLE THE BUTTON YOUR OWN WAY
//        middleBtn.setIcon(icon: .fontAwesomeSolid(.phone), iconSize: 20.0, color: UIColor.white, backgroundColor: .clear, forState: .normal)
//        middleBtn.applyGradient(colors: UIColor.lightGray.cgColor, UIColor.darkGray.cgColor,])
        middleBtn.setImage(UIImage(named: "middle"), for: .normal)
        self.tabBar.addSubview(middleBtn)
        middleBtn.addTarget(self, action: #selector(self.menuButtonAction), for: .touchUpInside)
        
        self.view.layoutIfNeeded()
    }
    
    // Menu Button Touch Action
    @objc func menuButtonAction(sender: UIButton) {
        self.selectedIndex = 2   //to select the middle tab. use "1" if you have only 3 tabs.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) {
            UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor: CustomColor.appColor.color], for: .selected)
            updateTabBarItemsTitles(selectedIndex: selectedIndex)
        }
    }
    
    func updateTabBarItemsTitles(selectedIndex: Int) {
        guard let viewControllers = viewControllers else { return }
        for (index, viewController) in viewControllers.enumerated() {
            if let tabBarItem = viewController.tabBarItem {
                if index == selectedIndex {
                    switch index {
                    case 0:
                        tabBarItem.title = "Home"
                    case 1:
                        tabBarItem.title = "Settings"
                    case 2:
                        tabBarItem.title = ""
                    case 3:
                        tabBarItem.title = "Notifications"
                    case 4:
                        tabBarItem.title = "Profile"
                    default:
                        break
                    }
                }else{
                    tabBarItem.title = ""
                }
            }
        }
    }
}
