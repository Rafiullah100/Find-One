//
//  NotificationViewController.swift
//  Find One
//
//  Created by MacBook Pro on 3/20/24.
//

import UIKit

class NotificationViewController: UIViewController {
    @IBOutlet weak var notificationLabel: UILabel!
    
    @IBOutlet weak var muteLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.notificationLabel.text = LocalizationKeys.pushNotification.rawValue.localizeString()
        self.muteLabel.text = LocalizationKeys.muteNotification.rawValue.localizeString()
        self.title = LocalizationKeys.notifications.rawValue.localizeString()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
