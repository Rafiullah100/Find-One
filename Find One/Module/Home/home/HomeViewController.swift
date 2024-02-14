//
//  HomeViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/12/24.
//

import UIKit
enum CellType {
    case feature
    case browse
    case sustainable
}

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "FeatureTableViewCell", bundle: nil), forCellReuseIdentifier: FeatureTableViewCell.cellReuseIdentifier())
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .home
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: FeatureTableViewCell = tableView.dequeueReusableCell(withIdentifier: FeatureTableViewCell.cellReuseIdentifier()) as! FeatureTableViewCell
        switch indexPath.row {
        case 0:
            cell.cellType = .feature
        case 1:
            cell.cellType = .browse
        case 2:
            cell.cellType = .sustainable
        default:
            cell.cellType = .feature
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 290.0
        case 1:
            return 145.0
        case 2:
            return 245.0
        default:
            return 0
        }
    }
}



