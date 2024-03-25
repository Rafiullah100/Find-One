//
//  SideMenuViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/26/24.
//

import UIKit

class SideMenuViewController: UIViewController {

    @IBOutlet weak var aboutUsLabel: UILabel!
    @IBOutlet weak var howToLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

//        aboutUsLabel.text = LocalizationKeys.about.rawValue.localizeString()
//        howToLabel.text = LocalizationKeys.home.rawValue.localizeString()

        nameLabel.text = UserDefaults.standard.name
        emailLabel.text = UserDefaults.standard.email
        imageView.sd_setImage(with: URL(string: UserDefaults.standard.profileImage ?? "" ), placeholderImage: UIImage(named: "Rectangle 405"))
    }

    @IBAction func logoutBtnAction(_ sender: Any) {
        UserDefaults.clean(exceptKeys: [UserDefaults.userdefaultsKey.selectedLanguage.rawValue,   UserDefaults.userdefaultsKey.appleUserData.rawValue])
        Switcher.logout(delegate: self)
    }
}
