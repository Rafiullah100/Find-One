//
//  AddReviewViewController.swift
//  Find One
//
//  Created by MacBook Pro on 3/15/24.
//

import UIKit
import Toast_Swift
class AddReviewViewController: BaseViewController {

    @IBOutlet var ratingImageView: [UIImageView]!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var textView: UITextView!{
        didSet{
            textView.delegate = self
        }
    }
    
    @IBOutlet weak var reviewLabel: UILabel!
    var rating: Int?
    let viewModel = DetailViewModel()
    var institudeID: Int?
    var delegate: AddReviewProtocol?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = "Add a review"
        textView.textColor = UIColor.lightGray

        viewModel.addReview.bind { [unowned self] review in
            self.stopAnimation()
            view.makeToast(review?.message ?? "")
            if review?.success == true{
                DispatchQueue.main.async {
                    self.dismiss(animated: true) {
                        self.delegate?.reviewAdded()
                    }
                }
            }
        }
    }
    
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    @IBAction func submitBtnAction(_ sender: Any) {
//        self.dismiss(animated: true)
        let add = ReviewInoutModel(review: textView.text, rating: rating, id: institudeID ?? 0)
        let validationResponse = viewModel.isFormValid(reviewInput: add)
        if validationResponse.isValid{
            self.animateSpinner()
            viewModel.submitReview()
        }
        else{
            showAlert(message: validationResponse.message)
        }
    }
    
    @IBAction func oneStarBtn(_ sender: Any) {
        giveStar(star: 1)
    }
    @IBAction func twoStarBtn(_ sender: Any) {
        giveStar(star: 2)
    }
    @IBAction func threeStarBtn(_ sender: Any) {
        giveStar(star: 3)
    }
    @IBAction func fourStarBtn(_ sender: Any) {
        giveStar(star: 4)
    }
    @IBAction func fiveStarBtn(_ sender: Any) {
        giveStar(star: 5)
    }
    
    private func giveStar(star: Int){
        for (index, starImageView) in ratingImageView.enumerated() {
            self.rating = star
            let imageName = index < star ? "star" : "star-unfil"
            starImageView.image = UIImage(named: imageName)
        }
    }
}


extension AddReviewViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Add a review"
            textView.textColor = UIColor.lightGray
        }
    }
}
