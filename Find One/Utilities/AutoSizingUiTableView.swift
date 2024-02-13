//
//  AutoSizingUiTableView.swift
//  Find 1
//
//  Created by MacBook Pro on 2/6/24.
//

import UIKit

class AutoSizingUiTableView: UITableView {
    
    var numberOfRows: Int = 0
    var cellHeight: CGFloat = 30.0
    
    override var intrinsicContentSize: CGSize {
        let requiredHeight = CGFloat(numberOfRows) * cellHeight
        return CGSize(width: UIView.noIntrinsicMetric, height: requiredHeight)
    }
}

