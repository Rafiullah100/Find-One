//
//  FeatureTableViewCell.swift
//  Find One
//
//  Created by MacBook Pro on 2/14/24.
//

import UIKit

class FeatureTableViewCell: UITableViewCell {

    var didTappedInstitute: ((Int, CellType) -> Void)? = nil

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "FeatureCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: FeatureCollectionViewCell.cellReuseIdentifier())
            collectionView.register(UINib(nibName: "CityCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CityCollectionViewCell.cellReuseIdentifier())
            collectionView.register(UINib(nibName: "SustainableCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: SustainableCollectionViewCell.cellReuseIdentifier())
        }
    }
    
    var citiesList: [CitiesResult]?
    var regionList: [RegionResult]?
    var sustainableList: [sustainableResult]?
    var featureList: [FeatureResult]?{
        didSet{
            self.collectionView.reloadData()
        }
    }

    var cellType: CellType?{
        didSet{
            switch cellType {
            case .feature:
                typeLabel.text = "Featured Institutions"
            case .city:
                typeLabel.text = "Browse by Cities"
            case .region:
                typeLabel.text = "Browse by Region"
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
        switch cellType {
        case .feature:
            return featureList?.count ?? 0
        case .city:
            return citiesList?.count ?? 0
        case .region:
            return regionList?.count ?? 0
        case .sustainable:
            return sustainableList?.count ?? 0
        default:
            return sustainableList?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch cellType {
        case .feature:
            let cell: FeatureCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: FeatureCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! FeatureCollectionViewCell
            cell.institute = featureList?[indexPath.row]
            return cell
        case .city:
            let cell: CityCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! CityCollectionViewCell
            cell.city = citiesList?[indexPath.row]
            return cell
        case .region:
            let cell: CityCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: CityCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! CityCollectionViewCell
            cell.region = regionList?[indexPath.row]
            return cell
        case .sustainable:
            let cell: SustainableCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: SustainableCollectionViewCell.cellReuseIdentifier(), for: indexPath) as! SustainableCollectionViewCell
            cell.sustainable = sustainableList?[indexPath.row]
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cellType {
        case .feature:
            return CGSize(width: 185, height: 250)
        case .city:
            return  CGSize(width: 100, height: 130)
        case .region:
            return  CGSize(width: 100, height: 130)
        case .sustainable:
            return  CGSize(width: 170, height: 195)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTappedInstitute?(indexPath.row, cellType ?? .feature)
    }
}

