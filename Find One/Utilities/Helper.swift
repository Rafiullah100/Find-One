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
        return CGSize(width: width, height: width * 0.8)
    }
    
    class func attributedText(text1: String, text2: String, text1Font: CGFloat? = 17, text2Font: CGFloat? = 14)-> NSMutableAttributedString{
        let text1Attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: Constants.fontRegular, size: text1Font ?? 17) ?? UIFont(),
            .foregroundColor: UIColor.label
        ]

        let text2Attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: Constants.fontRegular, size: text2Font ?? 14) ?? UIFont(),
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
    
   class func isRTL() -> Bool{
        return UserDefaults.standard.selectedLanguage == AppLanguage.arabic.rawValue ? true : false
    }
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
    
    class func timeAgoSince(_ strDate: String, langCode: String? = "") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")

        // Parse the string to a Date object
        guard let date = dateFormatter.date(from: strDate) else { return "" }
                 
        let calendar = Calendar.current
        let now = Date()
        let unitFlags: NSCalendar.Unit = [.second, .minute, .hour, .day, .weekOfYear, .month, .year]
        let components = (calendar as NSCalendar).components(unitFlags, from: date, to: now, options: [])

        if let year = components.year, year >= 2 {
                return "\(year) \(LocalizationKeys.yearsAgo.rawValue.localizeString())"
            
        }

        if let year = components.year, year >= 1 {
                return "\(year) \(LocalizationKeys.lastYear.rawValue.localizeString())"
            
        }

        if let month = components.month, month >= 2 {
                return "\(month) \(LocalizationKeys.monthsAgo.rawValue.localizeString())"
           
        }

        if let month = components.month, month >= 1 {
                return "\(month) \(LocalizationKeys.lastMonth.rawValue.localizeString())"
            
        }

        if let week = components.weekOfYear, week >= 2 {
                return "\(week) \(LocalizationKeys.weeksAgo.rawValue.localizeString())"
            
        }

        if let week = components.weekOfYear, week >= 1 {
            return "\(LocalizationKeys.lastWeek.rawValue.localizeString())"
            
        }

        if let day = components.day, day >= 2 {
            return "\(day) \(LocalizationKeys.daysAgo.rawValue.localizeString())"
            
        }

        if let day = components.day, day >= 1 {
            return "\(LocalizationKeys.yesterday.rawValue.localizeString())"
            
        }

        if let hour = components.hour, hour >= 2 {
            return "\(hour) \(LocalizationKeys.hoursAgo.rawValue.localizeString())"
            
        }

        if let hour = components.hour, hour >= 1 {
            return "\(LocalizationKeys.anhourAgo.rawValue.localizeString())"
            
        }

        if let minute = components.minute, minute >= 2 {
            return " \(minute) \(LocalizationKeys.minutesAgo.rawValue.localizeString())"
           
        }

        if let minute = components.minute, minute >= 1 {
            return "\(LocalizationKeys.aMinuteAgo.rawValue.localizeString())"
        }

        if let second = components.second, second >= 3 {
            return "\(second) \(LocalizationKeys.secondsAgo.rawValue.localizeString())"
            
        }
        else{
            return "\(LocalizationKeys.JustNow.rawValue.localizeString())"
        }
        
//        if langCode == "" {
//            return "\(LocalizationKeys.JustNow.rawValue.localizeString())"
//        }
//        else{
//            return "\(LocalizationKeys.JustNow.rawValue.localizeStringForLink(langCode: langCode ?? "en"))"
//        }
    }
    
class    func semantic(_ language: AppLanguage) -> UISemanticContentAttribute{
//        let language: AppLanguage = AppLanguage(rawValue: UserDefaults.standard.selectedLanguage ?? "") ?? .english
        print(language)
        switch language {
        case .english:
            return .forceLeftToRight
        case .arabic:
            return .forceRightToLeft
        }
    }
    
    class func cellSize(ipad: CGFloat, iphone: CGFloat) -> CGFloat{
        if UIDevice.current.userInterfaceIdiom == .pad{
            return ipad
        }
        else{
            return iphone
        }
    }

}


