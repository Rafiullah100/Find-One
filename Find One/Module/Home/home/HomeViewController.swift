//
//  HomeViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/12/24.
//

import UIKit
enum CellType {
    case feature
    case city
    case region
    case sustainable
}

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var sustainableCollectionView: UICollectionView!{
        didSet{
            sustainableCollectionView.dataSource = self
            sustainableCollectionView.delegate = self
            sustainableCollectionView.register(UINib(nibName: "SustainableCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "sustain")
        }
    }
    @IBOutlet weak var regionCollectionView: UICollectionView!{
        didSet{
            regionCollectionView.dataSource = self
            regionCollectionView.delegate = self
            regionCollectionView.register(UINib(nibName: "CityCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "city")

        }
    }
    @IBOutlet weak var cityCollectionView: UICollectionView!{
        didSet{
            cityCollectionView.dataSource = self
            cityCollectionView.delegate = self
            cityCollectionView.register(UINib(nibName: "CityCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "city")

        }
    }
    @IBOutlet weak var featureCollectionView: UICollectionView!{
        didSet{
            featureCollectionView.dataSource = self
            featureCollectionView.delegate = self
            featureCollectionView.register(UINib(nibName: "FeatureCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "feature")

        }
    }
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    
    var viewModel = HomeViewModel()
    var citiesList: [CitiesResult]?
    var regionList: [RegionResult]?
    var sustainableList: [sustainableResult]?
    var instituteList: [InstituteResult]?
    var featureList: [FeatureResult]?

    let dispatchGroup = DispatchGroup()
    var shouldReloadSustainableRow = false

    var indexRow: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        type = .home
        self.animateSpinner()
        viewModel.instituteList.bind { institute in
            self.stopAnimation()
            self.instituteList = institute
            self.indexRow = 0
            self.collectionView.reloadData()
            guard let _ = self.instituteList?[0].id else {return}
            self.callapi()
        }

        viewModel.featureList.bind { feature in
            self.featureList = feature
            self.featureCollectionView.reloadData()
        }
        
        viewModel.CitiesList.bind { cities in
            self.citiesList = cities
            self.cityCollectionView.reloadData()
        }
        
        viewModel.regionList.bind { regions in
            self.regionList = regions
            self.regionCollectionView.reloadData()
        }
        
        viewModel.sustainableList.bind { sustainable in
            self.stopAnimation()
            self.shouldReloadSustainableRow = true
            self.sustainableList = sustainable
            self.sustainableCollectionView.reloadData()
        }
        
        dispatchGroup.enter()
        viewModel.getInstituteList()
        dispatchGroup.leave()
    }
    
    private func callapi(){
        dispatchGroup.enter()
        self.viewModel.getFeatureList(levelID: self.instituteList?[0].id ?? 0)
        dispatchGroup.leave()
        dispatchGroup.enter()
        viewModel.getCitiesList()
        dispatchGroup.leave()
        dispatchGroup.enter()
        viewModel.getRregionList()
        dispatchGroup.leave()
        dispatchGroup.enter()
        viewModel.getSustainableList()
        dispatchGroup.leave()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
}

//extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 4
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell: FeatureTableViewCell = tableView.dequeueReusableCell(withIdentifier: FeatureTableViewCell.cellReuseIdentifier()) as! FeatureTableViewCell
//        tableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .automatic)
//        cell.didTappedInstitute = { index, type in
//            if type == .feature {
//                Switcher.gotoDetail(delegate: self)
//            }
//            else if type == .city {
//                Switcher.gotoResult(delegate: self)
//            }
//            else{
//                Switcher.gotoResult(delegate: self)
//            }
//        }
//        switch indexPath.row {
//        case 0:
//            cell.cellType = .feature
//            cell.featureList = featureList
//        case 1:
//            cell.cellType = .city
//            cell.citiesList = citiesList
//        case 2:
//            cell.cellType = .region
//            cell.regionList = regionList
//        case 3:
//            cell.cellType = .sustainable
//            cell.sustainableList = sustainableList
//        default:
//            cell.cellType = .feature
//        }
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        switch indexPath.row {
//        case 0:
//            return 290.0
//        case 1, 2:
//            return 220.0
//        case 3:
//            return 245.0
//        default:
//            return 0
//        }
//    }
//}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.featureCollectionView{
            return featureList?.count ?? 0
        }
        else if collectionView == self.regionCollectionView{
            print(regionList?.count ?? 0)
            return regionList?.count ?? 0
        }
        else if collectionView == self.cityCollectionView{
            return citiesList?.count ?? 0
        }
        else if collectionView == self.sustainableCollectionView{
            return sustainableList?.count ?? 0
        }
        else{
            return instituteList?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.featureCollectionView{
            let cell: FeatureCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "feature", for: indexPath) as! FeatureCollectionViewCell
            cell.institute = featureList?[indexPath.row]
            return cell
        }
        else if collectionView == self.regionCollectionView{
            let cell: CityCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "city", for: indexPath) as! CityCollectionViewCell
            cell.region = regionList?[indexPath.row]
            return cell
        }
        else if collectionView == self.cityCollectionView{
            let cell: CityCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "city", for: indexPath) as! CityCollectionViewCell
            cell.city = citiesList?[indexPath.row]
            return cell
        }
        else if collectionView == self.sustainableCollectionView{
            let cell: SustainableCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "sustain", for: indexPath) as! SustainableCollectionViewCell
            cell.sustainable = sustainableList?[indexPath.row]
            return cell
        }
        else{
            let cell: TypeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as! TypeCollectionViewCell
            cell.instituteType = instituteList?[indexPath.row]
            if indexRow == indexPath.row {
                cell.label.textColor = .black
                cell.dotView.isHidden = false
            }
            else{
                cell.label.textColor = .darkGray
                cell.dotView.isHidden = true

            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.featureCollectionView{
            return CGSize(width: 185, height: 220)
        }
        else if collectionView == self.cityCollectionView || collectionView == self.regionCollectionView{
            return CGSize(width: 150, height: 160)
        }
        else if collectionView == self.sustainableCollectionView{
            return CGSize(width: 170, height: 195)

        }
        else{
            return CGSize(width: collectionView.frame.width/4, height: collectionView.frame.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.featureCollectionView {
            Switcher.gotoDetail(delegate: self, id: featureList?[indexPath.row].id ?? 0, slug: sustainableList?[indexPath.row].slug ?? "")
        }
        else if collectionView == self.sustainableCollectionView{
            Switcher.gotoDetail(delegate: self, id: sustainableList?[indexPath.row].id ?? 0, slug: sustainableList?[indexPath.row].slug ?? "")
        }
        else if collectionView == self.cityCollectionView{
            Switcher.gotoResult(delegate: self, id: citiesList?[indexPath.row].id ?? 0, type: .city)
        }
        else if collectionView == self.regionCollectionView{
            Switcher.gotoResult(delegate: self, id: regionList?[indexPath.row].id ?? 0, type: .region)
        }
        else{
            indexRow = indexPath.row
            collectionView.reloadData()
            viewModel.getFeatureList(levelID: self.instituteList?[indexPath.row].id ?? 0)
        }
    }
}
