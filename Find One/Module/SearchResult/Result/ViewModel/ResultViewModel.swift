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
    
    func getSearchResult(regionID: Int? = nil, cityID: Int? = nil, typeID: Int? = nil, genderID: Int? = nil, minFee: Int? = nil, maxFee: Int? = nil, q: String? = nil){
//        let params = ["region_id": 1, "city_id": 1, "type_id": 1, "min_fee": minFee, "max_fee": maxFee, "gander_id": 1]
        var params = [String: Any]()
        if regionID != 0 && regionID != nil {
            params["region_id"] = regionID
        }
        if cityID != 0 && cityID != nil {
            params["city_id"] = cityID
        }
        if typeID != 0 && typeID != nil {
            params["type_id"] = typeID
        }
        if genderID != 0 && genderID != nil {
            params["gender_id"] = genderID
        }
        if maxFee != 0 && maxFee != nil {
            params["max_fee"] = maxFee
        }
        if minFee != 0 && minFee != nil {
            params["min_fee"] = minFee
        }
        
        if q != "" && q != nil {
            params["q"] = q
        }
        print(params)
        URLSession.shared.request(route: .search, method: .get, parameters: params, model: SearchModel.self) { result in
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
