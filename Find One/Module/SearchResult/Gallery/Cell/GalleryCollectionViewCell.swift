//
//  GalleryCollectionViewCell.swift
//  Find One
//
//  Created by MacBook Pro on 2/16/24.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var gallery: GalleryResult? {
        didSet{
            imgView.sd_setImage(with: URL(string: Route.imageBaseUrl + (gallery?.images ?? "") ), placeholderImage: UIImage(named: "Rectangle 405"))

        }
    }
}
