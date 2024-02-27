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
    
    @IBOutlet weak var collectionView: UICollectionView!{
        didSet{
            collectionView.dataSource = self
            collectionView.delegate = self
        }
    }
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "FeatureTableViewCell", bundle: nil), forCellReuseIdentifier: FeatureTableViewCell.cellReuseIdentifier())
        }
    }
    
    var viewModel = HomeViewModel()
    var citiesList: [CitiesResult]?
    var regionList: [RegionResult]?
    var sustainableList: [sustainableResult]?
    var instituteList: [InstituteResult]?
    var featureList: [FeatureResult]?

    let dispatchGroup = DispatchGroup()
    
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
            print(feature?.count)
            self.featureList = feature
            self.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        }
        
        viewModel.CitiesList.bind { cities in
            self.citiesList = cities
            self.tableView.reloadRows(at: [IndexPath(row: 1, section: 0)], with: .automatic)
        }
        
        viewModel.regionList.bind { regions in
            self.regionList = regions
            self.tableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .automatic)
        }
        
        viewModel.sustainableList.bind { sustainable in
            self.stopAnimation()
            self.sustainableList = sustainable
            self.tableView.reloadRows(at: [IndexPath(row: 3, section: 0)], with: .automatic)
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeatureTableViewCell = tableView.dequeueReusableCell(withIdentifier: FeatureTableViewCell.cellReuseIdentifier()) as! FeatureTableViewCell
        
        cell.didTappedInstitute = { index, type in
            if type == .feature {
                Switcher.gotoDetail(delegate: self)
            }
            else if type == .city {
                Switcher.gotoResult(delegate: self)
            }
            else{
                Switcher.gotoResult(delegate: self)
            }
        }
        switch indexPath.row {
        case 0:
            cell.cellType = .feature
            cell.featureList = featureList
        case 1:
            cell.cellType = .city
            cell.citiesList = citiesList
        case 2:
            cell.cellType = .region
            cell.regionList = regionList
        case 3:
            cell.cellType = .sustainable
            cell.sustainableList = sustainableList
        default:
            cell.cellType = .feature
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 290.0
        case 1, 2:
            return 145.0
        case 3:
            return 245.0
        default:
            return 0
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return instituteList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TypeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as! TypeCollectionViewCell
        cell.label.text = instituteList?[indexPath.row].name
        if indexPath.row == indexRow{
            cell.dotView.isHidden = false
            cell.label.textColor = .black
        }else{
            cell.dotView.isHidden = true
            cell.label.textColor = .darkGray
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/4, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexRow = indexPath.row
        collectionView.reloadData()
        viewModel.getFeatureList(levelID: self.instituteList?[indexPath.row].id ?? 0)
    }
}
