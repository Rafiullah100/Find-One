//
//  ReviewViewController.swift
//  Find One
//
//  Created by MacBook Pro on 2/16/24.
//

import UIKit

class ReviewViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: ReviewTableViewCell.cellReuseIdentifier())
        }
    }
    
    var viewModel = DetailViewModel()
    var reviewsDetail: [ReviewResult]?
    var id: Int?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: 0)
                
        viewModel.reviewDetails.bind { reviewDetail in
            self.stopAnimation()
            self.reviewsDetail = reviewDetail
            self.tableView.reloadData()
        }
        loadReview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = .clear
        
    }
    
    private func loadReview(){
        self.animateSpinner()
        viewModel.getReviewsDetails(id: id ?? 0, detailType: .reviews)
    }
    
    @IBAction func addReviewBtnAction(_ sender: Any) {
//        if Helper.isLogin() == true {
        Switcher.gotoAddReviewVC(delegate: self, instituteID: id ?? 0)
//        }
//        else{
//            self.view.makeToast("Login to comment")
//        }
    }
}

extension ReviewViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewsDetail?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ReviewTableViewCell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.cellReuseIdentifier()) as! ReviewTableViewCell
        cell.review = reviewsDetail?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}




extension ReviewViewController: AddReviewProtocol{
    func reviewAdded() {
       loadReview()
    }
}
