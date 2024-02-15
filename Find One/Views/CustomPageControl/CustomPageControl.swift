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

        let dotSize = activeImage.size // Size of your custom dot images
        let dotSpacing: CGFloat = 8.0

        var x = (rect.size.width - CGFloat(numberOfPages) * (dotSize.width + dotSpacing)) / 2.0

        for pageIndex in 0..<numberOfPages {
            let dotFrame = CGRect(x: x, y: (rect.size.height - dotSize.height) / 2, width: pageIndex == currentPage ? dotSize.width : dotSize.width, height: dotSize.height)
            let dotImage = pageIndex == currentPage ? activeImage : inactiveImage
            dotImage.draw(in: dotFrame)
            x += pageIndex == currentPage ? dotSize.width + dotSpacing : dotSize.width + dotSpacing
        }
    }
}
