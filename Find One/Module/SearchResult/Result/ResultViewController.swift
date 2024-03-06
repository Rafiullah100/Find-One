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

    var instType: ResultType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back
        tableView.showsVerticalScrollIndicator = false
        viewModel.instituteList.bind { result in
            self.stopAnimation()
            self.displayLabel.text = "Displaying all \(result?.count ?? 0) results"
            self.instituteList = result
            self.tableView.reloadData()
        }
        self.animateSpinner()
        switch instType {
        case .city:
            viewModel.getInstituteList(id: id ?? 0)
        case .region:
            viewModel.getInstituteListByRegion(id: id ?? 0)
        case nil:
            print("")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    @IBAction func mapBtnAction(_ sender: Any) {
        Switcher.gotoMap(delegate: self)
    }
}

extension ResultViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return instituteList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ResultTableViewCell = tableView.dequeueReusableCell(withIdentifier: ResultTableViewCell.cellReuseIdentifier()) as! ResultTableViewCell
        cell.institute = instituteList?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Switcher.gotoDetail(delegate: self, id: instituteList?[indexPath.row].id ?? 0, slug: instituteList?[indexPath.row].slug ?? "")
    }
}



