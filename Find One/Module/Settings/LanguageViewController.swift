//
//  LanguageViewController.swift
//  Qaaren
//
//  Created by MacBook Pro on 9/12/23.
//

import UIKit

//enum LanguageDirection: Int {
//    case rtl = 1
//    case ltr = 0
//}

enum AppLanguage: String {
    case arabic = "ar"
    case english = "en"
}

class LanguageViewController: BaseViewController {
    @IBOutlet weak var englishButton: UIButton!
    @IBOutlet weak var arabicButton: UIButton!
    
    @IBOutlet weak var arabicView: UIView!
    @IBOutlet weak var englishView: UIView!
    
    var selectedRadioButton: UIButton?
    var selectedLangIndexPath: IndexPath?

    @IBOutlet weak var englishLabel: UILabel!
    @IBOutlet weak var arabicLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .detail
//        viewControllerTitle = LocalizationKeys.languageSelection.rawValue.localizeString()
        englishLabel.text = "English"
        arabicLabel.text = "Arabic"
        saveButton.setTitle("Save", for: .normal)
//        print(UserDefaults.standard.selectedLanguage)
        if UserDefaults.standard.selectedLanguage != AppLanguage.arabic.rawValue{
            selectedRadioButton = englishButton
            radioButtonTapped(englishButton)
        }
        else{
            selectedRadioButton = arabicButton
            radioButtonTapped(arabicButton)
        }
    }

    @IBAction func english(_ sender: Any) {
//        selectedRadioButton?.isSelected = false
//        englishButton.isSelected = true
//        selectedRadioButton = englishButton
//        UserDefaults.standard.isRTL = LanguageDirection.ltr.rawValue
        radioButtonTapped(englishButton)
    }
    
    @IBAction func arabic(_ sender: Any) {
//        selectedRadioButton?.isSelected = false
//        arabicButton.isSelected = true
//        selectedRadioButton = arabicButton
//        UserDefaults.standard.isRTL = LanguageDirection.rtl.rawValue
        radioButtonTapped(arabicButton)
    }
    
    @IBAction func saveBtnAction(_ sender: Any) {
        Switcher.logout(delegate: self)
//        Switcher.gotoHome(delegate: self)
    }
    
    func radioButtonTapped(_ sender: UIButton) {
        selectedRadioButton?.isSelected = false
        selectedRadioButton?.layer.borderWidth = 1
        selectedRadioButton?.layer.borderColor = UIColor.gray.cgColor
        sender.isSelected = true
        sender.layer.borderWidth = 5
        sender.layer.borderColor = CustomColor.appColor.color.cgColor
        selectedRadioButton = sender
        if selectedRadioButton == englishButton {
            UserDefaults.standard.selectedLanguage = AppLanguage.english.rawValue
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        else{
            UserDefaults.standard.selectedLanguage = AppLanguage.arabic.rawValue
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
    }
}
