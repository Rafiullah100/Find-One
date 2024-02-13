//
//  Switcher.swift
//  Find 1
//
//  Created by MacBook Pro on 2/6/24.
//

import Foundation

import Foundation
import UIKit

class Switcher {
    static func gotoHome(delegate: UIViewController){
        let vc = UIStoryboard(name: Storyboard.home.rawValue, bundle: nil).instantiateViewController(withIdentifier: "MyTabBarCtrl") as! MyTabBarCtrl
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = false
        delegate.navigationController?.pushViewController(vc, animated: false)
    }
}
