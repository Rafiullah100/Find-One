//
//  ResultTableViewCell.swift
//  Find One
//
//  Created by MacBook Pro on 2/15/24.
//

import UIKit
import SDWebImage
class ResultTableViewCell: UITableViewCell {

    @IBOutlet var reviewStars: [UIImageView]!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var transportLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var institute: Results? {
        didSet{
            imgView.sd_setImage(with: URL(string: Route.imageBaseUrl + (institute?.imageURL ?? "") ), placeholderImage: UIImage(named: "Rectangle 405"))
            nameLabel.text = institute?.name ?? ""
            ratingLabel.text = institute?.reviewsAverage ?? "0"
            
            for (index, starImageView) in reviewStars.enumerated() {
                guard let rating = Double(institute?.reviewsAverage ?? "0") else { return }
                let imageName = index < Int(round(rating)) ? "star" : "star-unfil"
                starImageView.image = UIImage(named: imageName)
            }
        }
    }
    
    var searchInstitute: SearchResult? {
        didSet{
            imgView.sd_setImage(with: URL(string: Route.imageBaseUrl + (searchInstitute?.imageURL ?? "") ), placeholderImage: UIImage(named: "Rectangle 405"))
            nameLabel.text = searchInstitute?.name ?? ""
            ratingLabel.text = searchInstitute?.reviewsAvg ?? "0"
            typeLabel.text = searchInstitute?.gender
            locationLabel.text = "Location: \(searchInstitute?.city ?? "")  \(searchInstitute?.region ?? "")"
            
            for (index, starImageView) in reviewStars.enumerated() {
                guard let rating = Double(searchInstitute?.reviewsAvg ?? "0") else { return }
                let imageName = index < Int(round(rating)) ? "star" : "star-unfil"
                starImageView.image = UIImage(named: imageName)
            }
        }
    }
}
