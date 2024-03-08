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
    
    func getCitiesList(){
        URLSession.shared.request(route: .city, method: .get, parameters: [:], model: SearchCityModel.self) { result in
            switch result {
            case .success(let cities):
                self.citiesList.value = cities.result
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}
