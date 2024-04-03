//
//  FeeStructureViewTableViewCell.swift
//  Find One
//
//  Created by MacBook Pro on 2/16/24.
//

import UIKit

class FeeStructureViewTableViewCell: UITableViewCell {

    @IBOutlet weak var reservation: UILabel!
    @IBOutlet weak var girlsFee: UILabel!
    @IBOutlet weak var boysFee: UILabel!
    @IBOutlet weak var reservationLabel: UILabel!
    @IBOutlet weak var girlsFeeLabel: UILabel!
    @IBOutlet weak var boysFeeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dropDownImgView: UIImageView!
    @IBOutlet weak var collapseView: UIView!
    
    
    var fee: FeeResult?{
        didSet{
            boysFee.text = LocalizationKeys.boysFee.rawValue.localizeString()
            girlsFee.text = LocalizationKeys.girlsFee.rawValue.localizeString()
            reservation.text = LocalizationKeys.reservation.rawValue.localizeString()

            nameLabel.text = fee?.name
            boysFeeLabel.text = "\(fee?.fee ?? 0) \(LocalizationKeys.sar.rawValue.localizeString())"
            girlsFeeLabel.text = "\(fee?.fee ?? 0) \(LocalizationKeys.sar.rawValue.localizeString())"
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
