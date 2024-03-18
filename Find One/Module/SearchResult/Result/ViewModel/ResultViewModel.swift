//
//  ResultViewModel.swift
//  Find One
//
//  Created by MacBook Pro on 3/5/24.
//

import Foundation

class ResultViewModel {

    var instituteList: Observable<[Results]> = Observable(nil)
    var errorMessage: Observable<String> = Observable("")
    var searchResultList: Observable<[SearchResult]> = Observable(nil)

    func getInstituteList(id: Int){
        URLSession.shared.request(route: .institutesByCity, method: .get, parameters: ["city_id": id], model: ResultModel.self) { result in
            switch result {
            case .success(let institutes):
                self.instituteList.value = institutes.result
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getInstituteListByRegion(id: Int){
        URLSession.shared.request(route: .institutesByRegion, method: .get, parameters: ["city_id": id], model: ResultModel.self) { result in
            switch result {
            case .success(let institutes):
                self.instituteList.value = institutes.result
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getSearchResult(regionID: Int, cityID: Int, typeID: Int, genderID: Int, minFee: Int, maxFee: Int){
        print(regionID, cityID, typeID, genderID)
//        let params = ["region_id": 1, "city_id": 1, "type_id": 1, "min_fee": minFee, "max_fee": maxFee, "gander_id": 1]
//        print(params)
        URLSession.shared.request(route: .search, method: .get, parameters: [:], model: SearchModel.self) { result in
            switch result {
            case .success(let searchResult):
                self.searchResultList.value = searchResult.result
                print(searchResult)
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
}
