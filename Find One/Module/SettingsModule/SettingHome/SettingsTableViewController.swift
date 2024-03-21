//
//  SettingsTableViewController.swift
//  Find One
//
//  Created by MacBook Pro on 3/20/24.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var wishlistLabel: UILabel!
    @IBOutlet weak var policyLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var switchView: UISwitch!
    @IBOutlet var arrowIcons: [UIImageView]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = LocalizationKeys.settings.rawValue.localizeString()
    }

    @IBAction func changeAppAppearance(_ sender: Any) {
//        if switchView.isOn {
//            UIWindow.key?.overrideUserInterfaceStyle = .dark
//            UserDefaults.standard.appTheme = AppTheme.dark.rawValue
//        }
//        else{
//            UIWindow.key?.overrideUserInterfaceStyle = .light
//            UserDefaults.standard.appTheme = AppTheme.light.rawValue
//        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = ""
//        switchView.isOn = UserDefaults.standard.appTheme == AppTheme.dark.rawValue ? true : false
//        UIWindow.key?.overrideUserInterfaceStyle = UserDefaults.standard.appTheme == AppTheme.dark.rawValue ? .dark : .light
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        aboutLabel.text = LocalizationKeys.aboutQaaren.rawValue.localizeString()
//        policyLabel.text = LocalizationKeys.policy.rawValue.localizeString()
//        wishlistLabel.text = LocalizationKeys.wishlist.rawValue.localizeString()
//        languageLabel.text = LocalizationKeys.language.rawValue.localizeString()
//        modeLabel.text = LocalizationKeys.mode.rawValue.localizeString()
//        
//        arrowIcons.forEach { imageView in
//            imageView.image = UserDefaults.standard.selectedLanguage == AppLanguage.arabic.rawValue ? UIImage(named: "arrow-rtl") : UIImage(named: "arrow-ltr")
//        }
    }
    
    // MARK: - Table view data source

   /* override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }*/

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0{
//            Switcher.gotoAboutScreen(delegate: self)
//        }
//        else if indexPath.row == 1 {
//            Switcher.gotoPrivacyScreen(delegate: self)
//        }
//        else if indexPath.row == 2{
//            Switcher.gotoWishlist(delegate: self)
//        }
//        else if indexPath.row == 3{
//            Switcher.gotoLanguage(delegate: self)
//        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
