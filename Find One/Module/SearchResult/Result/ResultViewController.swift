//
//  ResultViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/15/24.
//

import UIKit

enum ResultType {
    case city
    case region
    case search
}

class ResultViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: ResultTableViewCell.cellReuseIdentifier())
        }
    }
    @IBOutlet weak var displayLabel: UILabel!
    
    var id: Int?
    var instituteList: [Results]?
    var viewModel = ResultViewModel()
    var searchList: [SearchResult]?

    var instType: ResultType?
    
    var regionID: Int?
    var cityID: Int?
    var typeID: Int?
    var minFee: Int?
    var maxFee: Int?
    var genderID: Int?
    var q: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back
        tableView.showsVerticalScrollIndicator = false
        viewModel.instituteList.bind { result in
            self.stopAnimation()
            self.displayLabel.text = "\( LocalizationKeys.displayingResult.rawValue.localizeString()) \(result?.count ?? 0) \( LocalizationKeys.result.rawValue.localizeString())"
            self.instituteList = result
            self.tableView.reloadData()
        }
        
        viewModel.searchResultList.bind { result in
            self.stopAnimation()
            self.displayLabel.text = "Displaying all \(result?.count ?? 0) results"
            self.searchList = result
            self.tableView.reloadData()
        }
        
        self.animateSpinner()
        switch instType {
        case .city:
            viewModel.getInstituteList(id: id ?? 0)
        case .region:
            viewModel.getInstituteListByRegion(id: id ?? 0)
        case .search:
            viewModel.getSearchResult(regionID: regionID ?? 0, cityID: cityID ?? 0, typeID: typeID ?? 0, genderID: regionID ?? 0, minFee: minFee ?? 0, maxFee: maxFee ?? 0, q: q)
        case nil:
            break
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    @IBAction func mapBtnAction(_ sender: Any) {
        Switcher.gotoMap(delegate: self, searchList: searchList ?? [])
    }
}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch instType {
        case .city, .region:
            return instituteList?.count ?? 0
        case .search:
            return searchList?.count ?? 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ResultTableViewCell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.cellReuseIdentifier()) as! ResultTableViewCell
        switch instType {
        case .city, .region:
            cell.institute = instituteList?[indexPath.row]
        case .search:
            cell.searchInstitute = searchList?[indexPath.row]
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id: Int?
        let slug: String?
        
        switch instType {
        case .city, .region:
            id = instituteList?[indexPath.row].id ?? 0
            slug = instituteList?[indexPath.row].slug ?? ""
        case .search:
            id = searchList?[indexPath.row].id ?? 0
            slug = searchList?[indexPath.row].slug ?? ""
        default:
            id = 0
            slug = ""
        }
        Switcher.gotoDetail(delegate: self, id: id ?? 0, slug: slug ?? "")
    }
}



