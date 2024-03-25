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
    
    static func gotoMap(delegate: UIViewController, searchList: [SearchResult]){
        let vc = UIStoryboard(name: Storyboard.result.rawValue, bundle: nil).instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        vc.searchList = searchList
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
            let nav = UINavigationController(rootViewController: loginVC)
            window.rootViewController = nav
            window.makeKeyAndVisible()
        }
    }
    
    
    static func gotoInformation(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.profile.rawValue, bundle: nil).instantiateViewController(withIdentifier: "PersonalInfoViewController") as! PersonalInfoViewController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.hidesBottomBarWhenPushed = false
        delegate.present(nav, animated: false, completion: nil)
    }
    
    static func gotoLanguage(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.settings.rawValue, bundle: nil).instantiateViewController(withIdentifier: "LanguageViewController") as! LanguageViewController
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .fullScreen
        nav.hidesBottomBarWhenPushed = false
        delegate.present(nav, animated: false, completion: nil)
    }
    
    static func gotoBooking(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.booking.rawValue, bundle: nil).instantiateViewController(withIdentifier: "BookingViewController") as! BookingViewController
        vc.modalPresentationStyle = .fullScreen
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoSerachResult(delegate: UIViewController, regionID: Int? = nil, cityID: Int? = nil, typeID: Int? = nil, minFee: Int? = nil, maxFee: Int? = nil, genderID: Int? = nil, q: String? = nil){
        let vc = UIStoryboard(name: Storyboard.result.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ResultViewController") as! ResultViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        vc.regionID = regionID
        vc.cityID = cityID
        vc.typeID = typeID
        vc.minFee = minFee
        vc.maxFee = maxFee
        vc.genderID = genderID
        vc.instType = .search
        vc.q = q
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func gotoAddReviewVC(delegate: UIViewController, instituteID: Int){
        let vc = UIStoryboard(name: Storyboard.result.rawValue, bundle: nil).instantiateViewController(withIdentifier: "AddReviewViewController") as! AddReviewViewController
        vc.delegate = delegate as? any AddReviewProtocol
        vc.institudeID = instituteID
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        delegate.present(vc, animated: true, completion: nil)
    }
    
    static func showFilter(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.menu.rawValue, bundle: nil).instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        vc.filterDelegate = delegate as? any FilterProtocol
        let nav = UINavigationController(rootViewController: vc)
        if let sheet = nav.sheetPresentationController {

            // 3
            sheet.detents = [.large()]

        }
        // 4
        delegate.present(nav, animated: true)
    }
    
    static func gotoUpdatePassword(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.auth.rawValue, bundle: nil).instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        delegate.navigationController?.pushViewController(vc, animated: true)
    }
    
}
