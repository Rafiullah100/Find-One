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
}
