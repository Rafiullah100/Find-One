//
//  ReviewTableViewCell.swift
//  Find One
//
//  Created by MacBook Pro on 2/16/24.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet var starsImgView: [UIImageView]!
    @IBOutlet weak var reviewLabel: UITextView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var review: ReviewResult? {
        didSet{
            imgView.sd_setImage(with: URL(string: Route.imageBaseUrl + (review?.user?.profileImage ?? "") ), placeholderImage: UIImage(named: "placeholder"))
            nameLabel.text = review?.user?.name
            timeLabel.text = review?.createdAt
            reviewLabel.text = review?.reviewText
            reviewLabel.textAlignment = Helper.isRTL() ? .right : .left
            timeLabel.textAlignment = Helper.isRTL() ? .left : .right
            timeLabel.text = Helper.timeAgoSince(review?.createdAt ?? "")

            for i in 0..<starsImgView.count {
                if i < review?.rating ?? 0 {
                    starsImgView[i].image = UIImage(named: "star")
                }
                else{
                    starsImgView[i].image = UIImage(named: "star-unfil")
                }
            }
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
