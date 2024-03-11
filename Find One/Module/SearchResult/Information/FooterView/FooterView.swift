//
//  FooterView.swift
//  Find One
//
//  Created by MacBook Pro on 3/11/24.
//

import UIKit

class FooterView: UICollectionReusableView {
        
    var didTappedBtn: (() -> Void)? = nil

    @IBAction func bookingBtnAction(_ sender: Any) {
        didTappedBtn?()
    }
}
