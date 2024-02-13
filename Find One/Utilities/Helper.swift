//
//  Helper.swift
//  Find 1
//
//  Created by MacBook Pro on 2/6/24.
//


import Foundation
import UIKit
open class Helper{
    
    class func cellSize(noOfCells: Int, space: Int, collectionView: UICollectionView)-> CGSize{
        let cellsAcross: CGFloat = CGFloat(noOfCells)
        let spaceBetweenCells: CGFloat = CGFloat(space)
        var width = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells)
        width = (width - 155) / cellsAcross
        print(width)
        return CGSize(width: width, height: 45)
    }
    
    class func attributedText(text1: String, text2: String)-> NSMutableAttributedString{
        let text1Attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: Constants.fontNameMedium, size: 19) ?? UIFont(),
            .foregroundColor: UIColor.label
        ]

        let text2Attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: Constants.fontNameMedium, size: 15) ?? UIFont(),
            .foregroundColor: UIColor.label
        ]

        let attributedString1 = NSAttributedString(string: text1, attributes: text1Attributes)
        let attributedString2 = NSAttributedString(string: text2, attributes: text2Attributes)

        let combinedAttributedString = NSMutableAttributedString()
        combinedAttributedString.append(attributedString1)
        combinedAttributedString.append(attributedString2)
        return combinedAttributedString
    }
    
    class func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
//   class func isRTL() -> Bool{
//        return UserDefaults.standard.selectedLanguage == AppLanguage.arabic.rawValue ? true : false
//    }
//
//    class func isLogin() -> Bool {
//        guard let login = UserDefaults.standard.isLogin else { return false }
//        return login
//    }
    
    class func parseLocalHtml(_ content: String) -> NSAttributedString {
        if let data = content.data(using: .utf8) {
            do {
                let attributedString = try NSAttributedString(data: data,
                                                              options: [.documentType: NSAttributedString.DocumentType.html],
                                                              documentAttributes: nil)
                return attributedString
            } catch {
                print("Error converting HTML to attributed string: \(error)")
            }
        } else {
            print("Error converting HTML to attributed string:")
        }
        return NSAttributedString("")
    }

    class func dateFormate(dateString: String) -> String {
        let inputDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let outputDateFormat = "dd MMMM yyyy"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputDateFormat
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        if let inputDate = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = outputDateFormat
            let outputDateString = dateFormatter.string(from: inputDate)
            print(outputDateString)
            return outputDateString
        } else {
            return ""
        }
    }
    
    class func showAlertWithButtons(title: String = "", message:String, buttonTitles:[String], completion: @escaping (_ responce: String) -> Void) {

        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

        for btnTitle in buttonTitles{
            let action = UIAlertAction(title: btnTitle, style: UIAlertAction.Style.default, handler: { action in
                completion(btnTitle)
            })
           alertController.addAction(action)
        }

        UIApplication.topViewController()?.present(alertController, animated: true, completion: nil)
    }
}


