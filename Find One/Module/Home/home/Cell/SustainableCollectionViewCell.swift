//
//  SustainableCollectionViewCell.swift
//  Find One
//
//  Created by MacBook Pro on 2/14/24.
//

import UIKit
import SDWebImage

class SustainableCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var susLabel: UILabel!
    var sustainable: sustainableResult? {
        didSet{
            label.text = sustainable?.name
            imgView.sd_setImage(with: URL(string: Route.imageBaseUrl + (sustainable?.imageURL ?? "") ), placeholderImage: UIImage(named: "placeholder"))
            susLabel.text = "\(sustainable?.sustainable ?? 0)% \(LocalizationKeys.sustainablePercentage.rawValue.localizeString())"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
