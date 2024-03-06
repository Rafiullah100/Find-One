//
//  TypeCollectionViewCell.swift
//  Find One
//
//  Created by MacBook Pro on 2/27/24.
//

import UIKit

class TypeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var dotView: UIView!
    
    var instituteType: InstituteResult?{
        didSet{
            label.text = instituteType?.name ?? ""
        }
    }

}
