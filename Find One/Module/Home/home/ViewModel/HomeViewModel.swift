//
//  HomeViewModel.swift
//  Find One
//
//  Created by MacBook Pro on 2/26/24.
//

import Foundation

class HomeViewModel {
    var CitiesList: Observable<[CitiesResult]> = Observable(nil)
    var errorMessage: Observable<String> = Observable("")

    var regionList: Observable<[RegionResult]> = Observable(nil)
    var sustainableList: Observable<[sustainableResult]> = Observable(nil)

    var instituteList: Observable<[InstituteResult]> = Observable(nil)
    var featureList: Observable<[FeatureResult]> = Observable(nil)

    
    func getCitiesList(){
        URLSession.shared.request(route: .citiesList, method: .get, parameters: [:], model: CitiesModel.self) { result in
            switch result {
            case .success(let cities):
                self.CitiesList.value = cities.result
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getRregionList(){
        URLSession.shared.request(route: .regionList, method: .get, parameters: [:], model: RegionModel.self) { result in
            switch result {
            case .success(let region):
                self.regionList.value = region.result
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getSustainableList(){
        URLSession.shared.request(route: .sustainable, method: .get, parameters: [:], model: sustainableModel.self) { result in
            switch result {
            case .success(let sustainable):
                self.sustainableList.value = sustainable.result
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getInstituteList(){
        URLSession.shared.request(route: .level, method: .get, parameters: [:], model: InstituteModel.self) { result in
            switch result {
            case .success(let isntitute):
                self.instituteList.value = isntitute.result
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getFeatureList(levelID: Int){
        URLSession.shared.request(route: .featureInstitute, method: .get, parameters: ["level_id": levelID], model: FeatureModel.self) { result in
            switch result {
            case .success(let feature):
                self.featureList.value = feature.result
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }

}
