//
//  ProfileTableViewCell.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/7/23.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        arrowImageView.image = UserDefaults.standard.selectedLanguage == AppLanguage.arabic.rawValue ? UIImage(named: "arrow-rtl") : UIImage(named: "arrow-ltr")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
