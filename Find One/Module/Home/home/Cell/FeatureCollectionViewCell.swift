//
//  FeatureCollectionViewCell.swift
//  Find One
//
//  Created by MacBook Pro on 2/14/24.
//

import UIKit

class FeatureCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var feeLabel: UILabel!
    @IBOutlet weak var educationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    var institute: FeatureResult? {
        didSet{
            nameLabel.text = institute?.name
            imgView.sd_setImage(with: URL(string: Route.imageBaseUrl + (institute?.imageURL ?? "") ), placeholderImage: UIImage(named: "Rectangle 405"))
            educationLabel.text = institute?.gender
            ratingLabel.text = "(\(institute?.reviewsAvg ?? "0"))"
            feeLabel.attributedText = Helper.attributedText(text1: "\(LocalizationKeys.startingFrom.rawValue.localizeString()) \(institute?.fee ?? 0)", text2: "\(LocalizationKeys.sar.rawValue.localizeString())", text1Font: 12, text2Font: 10)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topView.layer.masksToBounds = true
    }

}
