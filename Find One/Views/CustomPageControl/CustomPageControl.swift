//
//  CustomPageControl.swift
//  Find One
//
//  Created by MacBook Pro on 2/15/24.
//

import Foundation

import UIKit

class CustomPageControl: UIPageControl {
    var activeImage: UIImage?
    var inactiveImage: UIImage?

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let activeImage = activeImage, let inactiveImage = inactiveImage else {
            return
        }

        let dotSize = CGSize(width: inactiveImage.size.width * 5, height: inactiveImage.size.height) // Size of your custom dot images
        let dotSpacing: CGFloat = 5.0

        let totalInactiveWidth = CGFloat(numberOfPages - 1) * inactiveImage.size.width + CGFloat(numberOfPages - 1) * dotSpacing
        let totalWidth = totalInactiveWidth + dotSize.width

        var x = (rect.size.width - totalWidth) / 2.0

        for pageIndex in 0..<numberOfPages {
            let isCurrentPage = pageIndex == currentPage
            let dotFrame = CGRect(x: x, y: (rect.size.height - dotSize.height) / 2, width: isCurrentPage ? dotSize.width : inactiveImage.size.width, height: dotSize.height)
            let dotImage = isCurrentPage ? activeImage : inactiveImage
            dotImage.draw(in: dotFrame)
            x += isCurrentPage ? dotSize.width + dotSpacing : inactiveImage.size.width + dotSpacing
        }
    }
}
