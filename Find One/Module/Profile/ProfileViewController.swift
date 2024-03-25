//
//  ProfileViewController.swift
//  Find One
//
//  Created by MacBook Pro on 3/7/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ProfileTableViewCell", bundle: nil), forCellReuseIdentifier: ProfileTableViewCell.cellReuseIdentifier())
        }
    }
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabell: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var arr = [LocalizationKeys.personalInformation.rawValue.localizeString(), LocalizationKeys.delete.rawValue.localizeString()]
    var viewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.deleteAccount.bind { delete in
            if delete?.success == true{
                self.logoutUser()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(Route.imageBaseUrl + (UserDefaults.standard.profileImage ?? ""))
        imageView.layer.cornerRadius = imageView.frame.size.width * 0.5
        imageView.sd_setImage(with: URL(string: UserDefaults.standard.profileImage ?? "" ), placeholderImage: UIImage(named: "Rectangle 405"))
        nameLabell.text = UserDefaults.standard.name?.capitalized
        usernameLabel.text = UserDefaults.standard.email
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProfileTableViewCell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.cellReuseIdentifier()) as! ProfileTableViewCell
        cell.titleLabel.text = arr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            Switcher.gotoInformation(delegate: self)
        }
        //        else if indexPath.row == 1{
        //            Switcher.gotoMySources(delegate: self)
        //        }
        //        else if indexPath.row == 2{
        //            Switcher.gotoMyCategory(delegate: self)
        //        }
        //        else if indexPath.row == 3{
        //            Switcher.gotoWishlist(delegate: self)
        //        }
        else {
            //            showAlert(message: "Are you sure you want to delete your account?")
            Helper.showAlertWithButtons(message: "Are you sure you want to delete your account?", buttonTitles: ["Cancel", "Ok"]) { response in
                if response == "Ok"{
                    self.viewModel.delete()
                }
            }
        }
    }
    
    func logoutUser() {
        UserDefaults.clean(exceptKeys: [UserDefaults.userdefaultsKey.selectedLanguage.rawValue, UserDefaults.userdefaultsKey.appleUserData.rawValue])
        Switcher.logout(delegate: self)
    }
}

