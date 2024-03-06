//
//  FeeStructureViewTableViewCell.swift
//  Find One
//
//  Created by MacBook Pro on 2/16/24.
//

import UIKit

class FeeStructureViewTableViewCell: UITableViewCell {

    @IBOutlet weak var reservationLabel: UILabel!
    @IBOutlet weak var girlsFeeLabel: UILabel!
    @IBOutlet weak var boysFeeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dropDownImgView: UIImageView!
    @IBOutlet weak var collapseView: UIView!
    
    
    var fee: FeeResult?{
        didSet{
            nameLabel.text = fee?.name
            boysFeeLabel.text = "\(fee?.fee ?? 0) SAR"
            girlsFeeLabel.text = "\(fee?.fee ?? 0) SAR"
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
