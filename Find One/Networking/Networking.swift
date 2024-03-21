//
//  Networking.swift
//  Find 1
//
//  Created by MacBook Pro on 2/6/24.
//

import Foundation

import UIKit
import Alamofire

class Networking{
    static let shared = Networking()
    
    func updateProfile(route: Route, imageParameter: String, image: UIImage, parameters: [String: Any], completion: @escaping (Result<EditProfileModel, AppError>) -> Void) {

        let urlStr = Route.baseUrl + route.description
        //        let urlRequest: Alamofire.URLRequestConvertible = URLRequest(url: url)
        let imageData = image.jpegData(compressionQuality: 1.0)
        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "x-access-token": "\(UserDefaults.standard.token ?? "")"
        ]
        //file name
        let date: Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'_'HH:mm:ss"
        let imageName = "\(dateFormatter.string(from: date)).jpg"
        //        let URL = try! URLRequest(url: url, method: .post, headers: headers)
        //        SVProgressHUD.show(withStatus: "Please Wait...")
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                multipartFormData.append("\(value)".data(using: String.Encoding.utf8) ?? Data(), withName: key as String)
            }
            multipartFormData.append(imageData ?? Data(), withName: imageParameter, fileName: imageName, mimeType: "image/jpg")
        }, to: urlStr, headers: headers)
        .responseDecodable(of: EditProfileModel.self) { (response) in
            //            SVProgressHUD.dismiss()
            switch response.result{
            case .success(let success):
                completion(.success(success))
            case .failure(let error):
                print(error)
                completion(.failure(AppError.unknownError))
            }
        }
    }
}
    
    
