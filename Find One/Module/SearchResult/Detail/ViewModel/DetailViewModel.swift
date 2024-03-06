//
//  DetailViewModel.swift
//  Find One
//
//  Created by MacBook Pro on 3/5/24.
//

import Foundation

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
}
