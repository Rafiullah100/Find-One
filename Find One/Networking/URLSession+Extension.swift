//
//  URLSession+Extension.swift
//  Find 1
//
//  Created by MacBook Pro on 2/6/24.
//

import Foundation


import Foundation
import UIKit
extension URLSession{
    func request<T: Codable>(route: Route, method: Method, showLoader: Bool? = true, parameters: [String: Any]? = nil, model: T.Type, completion: @escaping (Result<T, AppError>) -> Void) {
        
//        if !Reachability.isConnectedToNetwork() {
//            completion(.failure(.noInternet))
//        }
        guard let request = createRequest(route: route, method: method, parameters: parameters) else {
            completion(.failure(AppError.unknownError))
            return
        }
        
        let task = dataTask(with: request) { data, response, error in
            guard let data = data else {
                if let error = error{
                    print(error)
                    DispatchQueue.main.async {
                        completion(.failure(.serverError))
                    }
                }
                else{
                    DispatchQueue.main.async {
                        completion(.failure(AppError.serverError))
                    }
                }
                return
            }
            do {
                let result = try JSONDecoder().decode(model, from: data)
                print(result)
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch let error {
                print(error)
                DispatchQueue.main.async {
                    completion(.failure(AppError.errorDecoding))
                }
            }
        }
        task.resume()
    }
    
    func createRequest(route: Route,
                               method: Method,
                               parameters: [String: Any]? = nil) -> URLRequest? {
        var urlString = ""
//        if route == .weatherApi  {
//            urlString = route.description
//        }
//        else{
            urlString = Route.baseUrl + route.description
//        }
        print(urlString)
        guard let url = urlString.asUrl else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue(UserDefaults.standard.token ?? "", forHTTPHeaderField: "x-access-token")
//        urlRequest.addValue(UserDefaults.standard.languageCode ?? "", forHTTPHeaderField: "lang-code")
        print(UserDefaults.standard.token ?? "")
        urlRequest.httpMethod = method.rawValue
        print(urlRequest.headers)
        if let params = parameters {
            switch method {
            case .get:
                var urlComponent = URLComponents(string: urlString)
                urlComponent?.queryItems = params.map { URLQueryItem(name: $0, value: "\($1)") }
                urlRequest.url = urlComponent?.url
                print(urlRequest)
            case .post, .delete, .patch:
                let bodyData = try? JSONSerialization.data(withJSONObject: params, options: [])
                urlRequest.httpBody = bodyData
            }
        }
        return urlRequest
    }
}
