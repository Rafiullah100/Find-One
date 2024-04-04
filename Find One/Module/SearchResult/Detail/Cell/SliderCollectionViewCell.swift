//
//  SliderCollectionViewCell.swift
//  Find One
//
//  Created by MacBook Pro on 3/21/24.
//

import UIKit

class SliderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var gallery: InstituteGallery? {
        didSet{
            imgView.sd_setImage(with: URL(string: Route.imageBaseUrl + (gallery?.imageURL ?? "") ), placeholderImage: UIImage(named: "placeholder"))
        }
    }
}
