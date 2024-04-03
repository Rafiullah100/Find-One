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
    
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var sustainableLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var browseLabel: UILabel!
    @IBOutlet weak var featureLabel: UILabel!
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
    var levelID: Int?
    var isFiltered = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        featureLabel.text = LocalizationKeys.feature.rawValue.localizeString()
        browseLabel.text = LocalizationKeys.browseCity.rawValue.localizeString()
        regionLabel.text = LocalizationKeys.browseRegion.rawValue.localizeString()
        sustainableLabel.text = LocalizationKeys.sustainableInst.rawValue.localizeString()
        browseLabel.textAlignment = Helper.isRTL() ? .right : .left
        regionLabel.textAlignment = Helper.isRTL() ? .right : .left
        sustainableLabel.textAlignment = Helper.isRTL() ? .right : .left

        type = .home
        self.animateSpinner()
        viewModel.instituteList.bind { institute in
            self.stopAnimation()
            self.instituteList = institute
            self.indexRow = 0
            self.collectionView.reloadData()
            guard let levid = self.instituteList?[0].id else {return}
            self.levelID = levid
            self.callapi()
            
        }

        viewModel.featureList.bind { feature in
            self.featureList = feature
            self.featureList?.count == 0 ? self.featureCollectionView.setEmptyView() : self.featureCollectionView.setEmptyView("")
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
    @IBAction func filterBtnAction(_ sender: Any) {
        if isFiltered == true {
            isFiltered = false
            self.viewModel.getFeatureList(levelID: self.instituteList?[0].id ?? 0)
            filterButton.setImage(UIImage(named: "filter"), for: .normal)
        }
        else{
            Switcher.showFilter(delegate: self)
        }
    }
}

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
                cell.label.textColor = .label
                cell.dotView.isHidden = false
            }
            else{
                cell.label.textColor = CustomColor.tabTextColor.color
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
            Switcher.gotoDetail(delegate: self, id: featureList?[indexPath.row].id ?? 0, slug: featureList?[indexPath.row].slug ?? "")
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
            levelID = self.instituteList?[indexPath.row].id ?? 0
            indexRow = indexPath.row
            collectionView.reloadData()
            viewModel.getFeatureList(levelID: self.instituteList?[indexPath.row].id ?? 0)
        }
    }
}

extension HomeViewController: FilterProtocol{
    func filter(cityID: Int, regionID: Int, curriculumID: Int, stageID: Int, genderID: Int, instituteType: Int) {
        isFiltered = true
        filterButton.setImage(UIImage(named: "reload"), for: .normal)
        viewModel.getFeatureList(levelID: levelID ?? 0, regionID: regionID, cityID: cityID, typeID: instituteType, genderID: genderID, gradeID: stageID, curriculumID: curriculumID)
    }
}
