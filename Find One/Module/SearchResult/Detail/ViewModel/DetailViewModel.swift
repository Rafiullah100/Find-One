//
//  DetailViewModel.swift
//  Find One
//
//  Created by MacBook Pro on 3/5/24.
//

import Foundation

protocol AddReviewProtocol {
    func reviewAdded()
}

enum DetailType: String {
    case sustainability = "sustainability"
    case fee = "fee_structure"
    case gallery = "gallery"
    case reviews = "reviews"
    case location = "location"
}

class DetailViewModel {
    
    var details: Observable<DetailModel> = Observable(nil)
    var errorMessage: Observable<String> = Observable("")
    var feeDetails: Observable<[FeeResult]> = Observable(nil)
    var galleryDetails: Observable<[GalleryResult]> = Observable(nil)
    var locationDetails: Observable<LocationResult> = Observable(nil)
    var reviewDetails: Observable<[ReviewResult]> = Observable(nil)
    var addReview: Observable<AddReviewModel> = Observable(nil)
    var reviewParameters: [String: Any]?

    func getInstituteDetails(id: Int, slug: String){
        URLSession.shared.request(route: .detail, method: .get, parameters: ["institute_id": id, "slug": slug], model: DetailModel.self) { result in
            switch result {
            case .success(let details):
                self.details.value = details
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getFeeDetails(id: Int, detailType: DetailType){
        URLSession.shared.request(route: .detailRelated, method: .get, parameters: ["institute_id": id, "type": detailType.rawValue], model: FeeStructureModel.self) { result in
            switch result {
            case .success(let feeDetails):
                self.feeDetails.value = feeDetails.result
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getGalleryDetails(id: Int, detailType: DetailType){
        URLSession.shared.request(route: .detailRelated, method: .get, parameters: ["institute_id": id, "type": detailType.rawValue], model: GalleryModel.self) { result in
            switch result {
            case .success(let galleryDetails):
                print(galleryDetails)
                self.galleryDetails.value = galleryDetails.result
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getLocationDetails(id: Int, detailType: DetailType){
        URLSession.shared.request(route: .detailRelated, method: .get, parameters: ["institute_id": id, "type": detailType.rawValue], model: LocationModel.self) { result in
            switch result {
            case .success(let locationDetails):
                self.locationDetails.value = locationDetails.result
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getReviewsDetails(id: Int, detailType: DetailType){
        URLSession.shared.request(route: .detailRelated, method: .get, parameters: ["institute_id": id, "type": detailType.rawValue], model: ReviewModel.self) { result in
            switch result {
            case .success(let reviewsDetails):
                self.reviewDetails.value = reviewsDetails.result
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func submitReview(){
        URLSession.shared.request(route: .addReview, method: .post, parameters: reviewParameters, model: AddReviewModel.self) { result in
            switch result {
            case .success(let addReview):
                self.addReview.value = addReview
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func isFormValid(reviewInput: ReviewInoutModel) -> ValidationResponse {
        if reviewInput.review == nil || reviewInput.rating == nil || reviewInput.review ==  "Add a review" {
            return ValidationResponse(isValid: false, message: "Please fill all field and try again!")
        }
        else{
            reviewParameters = ["institute_id": reviewInput.id!, "rating": reviewInput.rating!, "review_text": reviewInput.review!]
            return ValidationResponse(isValid: true, message: "")
        }
    }
}
