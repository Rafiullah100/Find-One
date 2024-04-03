//
//  FacilitiesCollectionViewCell.swift
//  Find One
//
//  Created by MacBook Pro on 4/3/24.
//

import UIKit

class FacilitiesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var facilities: SearchFacilityDescription?{
        didSet{
            label.text = facilities?.name
        }
    }
    
    
}
