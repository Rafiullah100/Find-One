//
//  BrowseCollectionViewCell.swift
//  Find One
//
//  Created by MacBook Pro on 2/14/24.
//

import UIKit
import SDWebImage
class CityCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    var city: CitiesResult? {
        didSet{
            label.text = city?.name
            countLabel.text = "\(city?.instituteCount ?? 0)+"
            imgView.sd_setImage(with: URL(string: Route.imageBaseUrl + (city?.imageURL ?? "") ), placeholderImage: UIImage(named: "Rectangle 405"))
        }
    }
    
    var region: RegionResult? {
        didSet{
            label.text = region?.name
            countLabel.text = "\(region?.instituteCount ?? 0)+"
            imgView.sd_setImage(with: URL(string: Route.imageBaseUrl + (region?.imageURL ?? "") ), placeholderImage: UIImage(named: "Rectangle 405"))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
