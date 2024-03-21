//
//  SearchViewModel.swift
//  Find One
//
//  Created by MacBook Pro on 3/8/24.
//

import Foundation

class SearchViewModel {
    var regionList: Observable<[RegionResultModel]> = Observable(nil)
    var errorMessage: Observable<String> = Observable("")
    var citiesList: Observable<[CityResultModel]> = Observable(nil)
    var curriculam: Observable<[InstitutetypeResult]> = Observable(nil)
    var genderList: Observable<[GenderResult]> = Observable(nil)

    
    func getRegionList(){
        URLSession.shared.request(route: .region, method: .get, parameters: [:], model: SearchRegionModel.self) { result in
            switch result {
            case .success(let regions):
                self.regionList.value = regions.result
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getCitiesList(regionID: Int){
        URLSession.shared.request(route: .city, method: .get, parameters: ["region_id": regionID], model: SearchCityModel.self) { result in
            switch result {
            case .success(let cities):
                self.citiesList.value = cities.result
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getCurriculamType(){
        URLSession.shared.request(route: .type, method: .get, parameters: [:], model: InstitutetypeModel.self) { result in
            switch result {
            case .success(let curriculam):
                self.curriculam.value = curriculam.result
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getGender(){
        URLSession.shared.request(route: .gender, method: .get, parameters: [:], model: GenderModel.self) { result in
            switch result {
            case .success(let gender):
                self.genderList.value = gender.result
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}
