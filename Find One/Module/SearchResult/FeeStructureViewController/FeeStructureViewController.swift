//
//  FeeStructureViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/16/24.
//

import UIKit

class FeeStructureViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "FeeStructureViewTableViewCell", bundle: nil), forCellReuseIdentifier: FeeStructureViewTableViewCell.cellReuseIdentifier())
        }
    }
    
    var cellExpanded: [Bool] = Array(repeating: true, count: 5)
    var viewModel = DetailViewModel()
    var feeDetail: [FeeResult]?
    var id: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
        
        viewModel.feeDetails.bind { feeDetail in
            self.stopAnimation()
            self.feeDetail = feeDetail
            self.tableView.reloadData()
        }
        self.animateSpinner()
        viewModel.getFeeDetails(id: id ?? 0, detailType: .fee)
    }
    
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .clear
    }
}

extension FeeStructureViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feeDetail?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(cellExpanded[indexPath.row])
        let cell: FeeStructureViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: FeeStructureViewTableViewCell.cellReuseIdentifier()) as! FeeStructureViewTableViewCell
        cell.collapseView.isHidden = cellExpanded[indexPath.row]
        cell.dropDownImgView.image = cellExpanded[indexPath.row] == false ? UIImage(named: "expanded") : UIImage(named: "collapsed")
        cell.fee = feeDetail?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellExpanded[indexPath.row].toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}



