//
//  FeatureTableViewCell.swift
//  Find One
//
//  Created by MacBook Pro on 2/14/24.
//

import UIKit

class FeatureTableViewCell: UITableViewCell {

    var didTappedInstitute: ((Int) -> Void)? = nil

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "FeatureCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: FeatureCollectionViewCell.cellReuseIdentifier())
            collectionView.register(UINib(nibName: "BrowseCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: BrowseCollectionViewCell.cellReuseIdentifier())
            collectionView.register(UINib(nibName: "SustainableCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: SustainableCollectionViewCell.cellReuseIdentifier())
        }
    }
    
    var cellType: CellType?{
        didSet{
            switch cellType {
            case .feature:
                typeLabel.text = "Featured Institutions"
            case .browse:
                typeLabel.text = "Browse by Cities"
            case .sustainable:
                typeLabel.text = "Sustainable Institutes"
            default:
                print("")
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension FeatureTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch cellType {
        case .feature:
            let cell: FeatureCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: FeatureCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! FeatureCollectionViewCell
            return cell
        case .browse:
            let cell: BrowseCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: BrowseCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! BrowseCollectionViewCell
            return cell
        case .sustainable:
            let cell: SustainableCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: SustainableCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! SustainableCollectionViewCell
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cellType {
        case .feature:
            return CGSize(width: 185, height: 250)
        case .browse:
            return  CGSize(width: 100, height: 130)
        case .sustainable:
            return  CGSize(width: 170, height: 195)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTappedInstitute?(indexPath.row)
    }
}

