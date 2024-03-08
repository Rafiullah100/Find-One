//
//  Switcher.swift
//  Find 1
//
//  Created by MacBook Pro on 2/6/24.
//

import Foundation

import Foundation
import UIKit

enum InititialViewController {
    case login
    case home
}

class Switcher {
    static func gotoHome(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "MyTabBarCtrl") as! MyTabBarCtrl
//        vc.modalPresentationStyle = .fullScreen
        let nav = UINavigationController(rootViewController: vc)
        nav.hidesBottomBarWhenPushed = false
        nav.modalPresentationStyle = .fullScreen
        delegate.present(nav, animated: true)
    }
    
    static func gotoResult(delegate: UIViewController, id: Int, type: ResultType){
        let vc = UIStoryboard(name: Storyboard.result.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        vc.id = id
        vc.instType = type
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoDetail(delegate: UIViewController, id: Int, slug: String){
        let vc = UIStoryboard(name: Storyboard.result.rawValue, bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        vc.id = id
        vc.slug = slug
        print(id, slug)
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoMap(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.result.rawValue, bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoLocation(delegate: UIViewController, id: Int){
        let vc = UIStoryboard(name: Storyboard.result.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LocationViewController") as! LocationViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true
        vc.id = id
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoLogin(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true
        delegate.present(vc, animated: true)
    }
    
    static func logout(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true
        delegate.navigationController?.pushViewController(vc, animated: false)
//        delegate.present(vc, animated: true)
    }
    
    static func setInitialScreen(vc: InititialViewController){
        if vc == .home{
            let homeVC = UIStoryboard(name: Storyboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "MyTabBarCtrl") as! MyTabBarCtrl
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = homeVC
            window.makeKeyAndVisible()
        }
        else{
            let loginVC = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = loginVC
            window.makeKeyAndVisible()
        }
    }
    
    static func gotoInformation(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "PersonalInfoViewController") as! PersonalInfoViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
}
