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
    
    func getFeatureList(levelID: Int, regionID: Int? = nil, cityID: Int? = nil, typeID: Int? = nil, genderID: Int? = nil, gradeID: Int? = nil, curriculumID: Int? = nil){
        var params = ["level_id": levelID]
        if regionID != 0 && regionID != nil {
            guard let regionID = regionID else { return }
            params["region_id"] = regionID
        }
        if cityID != 0 && cityID != nil {
            guard let cityID = cityID else { return }
            params["city_id"] = cityID
        }
        if typeID != 0 && typeID != nil{
            guard let typeID = typeID else { return }
            params["type_id"] = typeID
        }
        if genderID != 0 && genderID != nil{
            guard let genderID = genderID else { return }
            params["gender_id"] = genderID
        }
        if gradeID != 0 && gradeID != nil{
            guard let gradeID = gradeID else { return }
            params["grade_id"] = gradeID

        }
        if curriculumID != 0 && curriculumID != nil{
            guard let curriculumID = curriculumID else { return }
            params["curriculam_id"] = curriculumID
        }
        print(params)
        
        URLSession.shared.request(route: .featureInstitute, method: .get, parameters: params, model: FeatureModel.self) { result in
            switch result {
            case .success(let feature):
                self.featureList.value = feature.result
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}
