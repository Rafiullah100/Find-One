//
//  PersonalInfoViewController.swift
//  Find One
//
//  Created by MacBook Pro on 3/8/24.
//

import UIKit
enum ImageSource {
    case photoLibrary
    case camera
}
class PersonalInfoViewController: BaseViewController {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var segmentView: UISegmentedControl!
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet var editButtons: [UIButton]!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    
    @IBOutlet weak var aboutTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var countryTextField: UITextField!
    var imagePicker: UIImagePickerController!
    private var viewModel = ProfileViewModel()

    var genderArr = [LocalizationKeys.male.rawValue.localizeString(), LocalizationKeys.female.rawValue.localizeString(), LocalizationKeys.other.rawValue.localizeString()]
    var gender = LocalizationKeys.male.rawValue.localizeString()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back
        viewControllerTitle = "Personal Information"
        
        nameTextField.textAlignment = Helper.isRTL() ? .right : .left
        emailTextField.textAlignment = Helper.isRTL() ? .right : .left
        mobileTextField.textAlignment = Helper.isRTL() ? .right : .left
        countryTextField.textAlignment = Helper.isRTL() ? .right : .left
        cityTextField.textAlignment = Helper.isRTL() ? .right : .left
        aboutTextField.textAlignment = Helper.isRTL() ? .right : .left

        nameTextField.placeholder = LocalizationKeys.name.rawValue.localizeString()
        emailTextField.placeholder = LocalizationKeys.email.rawValue.localizeString()
        mobileTextField.placeholder = LocalizationKeys.contactNumber.rawValue.localizeString()
        countryTextField.placeholder = LocalizationKeys.country.rawValue.localizeString()
        cityTextField.placeholder = LocalizationKeys.city.rawValue.localizeString()
        aboutTextField.placeholder = LocalizationKeys.about.rawValue.localizeString()
        saveButton.setTitle(LocalizationKeys.save.rawValue.localizeString(), for: .normal)
        updateButton.setTitle(LocalizationKeys.updatePassword.rawValue.localizeString(), for: .normal)
        
        segmentView.removeAllSegments()
        for i in 0..<(self.genderArr.count){
            self.segmentView.insertSegment(withTitle: self.genderArr[i], at: i, animated: true)
            self.segmentView.selectedSegmentIndex = 0
        }
        
        self.animateSpinner()
        viewModel.editProfile.bind { updateProfile in
            DispatchQueue.main.async {
                guard let updateProfile = updateProfile else { return }
                self.stopAnimation()
                self.viewModel.getMyProfile()
                self.view.makeToast(updateProfile.message)
            }
        }
        
        viewModel.myProfile.bind { _ in
            DispatchQueue.main.async {
                self.stopAnimation()
                self.updateUI()
            }
        }
        viewModel.getMyProfile()
    }
    
    private func updateUI(){
        nameTextField.text = viewModel.getName()
        emailTextField.text = viewModel.getEmail()
        imageView.sd_setImage(with: URL(string: viewModel.getImage()), placeholderImage: UIImage(named: "placeholder"))
        mobileTextField.text = viewModel.getMobile()
        countryTextField.text = viewModel.getCountry()
        cityTextField.text = viewModel.getCity()
        aboutTextField.text = viewModel.getAbout()
        gender = viewModel.getGender()
        for (index, item) in genderArr.enumerated() {
            if item.lowercased() == gender.lowercased() {
                segmentView.selectedSegmentIndex = index
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        imageView.layer.cornerRadius = imageView.frame.size.width * 0.5
    }

    @IBAction func nameEditBtn(_ sender: Any) {
        nameTextField.becomeFirstResponder()
        nameTextField.isUserInteractionEnabled.toggle()
    }
    
    @IBAction func emailEditBtn(_ sender: Any) {
        emailTextField.becomeFirstResponder()
        emailTextField.isUserInteractionEnabled.toggle()
    }
    
    @IBAction func phoneEditBtn(_ sender: Any) {
        mobileTextField.becomeFirstResponder()
        mobileTextField.isUserInteractionEnabled.toggle()
    }
    
    @IBAction func cameraBtnAction(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            self.selectImageFrom(.photoLibrary)
            return
        }
        self.selectImageFrom(.camera)
    }
    
    func selectImageFrom(_ source: ImageSource){
        imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        switch source {
        case .camera:
            imagePicker.sourceType = .camera
        case .photoLibrary:
            imagePicker.sourceType = .photoLibrary
        }
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func segmentAction(_ sender: Any) {
        let selectedIndex = segmentView.selectedSegmentIndex
        gender = genderArr[selectedIndex]
    }
    
    @IBAction func saveBtnAction(_ sender: Any) {
        let edit = EditProfileInputModel(name: nameTextField.text ?? "", email: emailTextField.text ?? "", mobile: mobileTextField.text ?? "", image: imageView.image ?? UIImage(), about: aboutTextField.text ?? "", city: cityTextField.text ?? "", country: countryTextField.text ?? "", gender: gender)
        let validationResponse = viewModel.isFormValid(user: edit)
        if validationResponse.isValid {
            self.animateSpinner()
            viewModel.updateProfile(image: imageView.image ?? UIImage())
        }
        else{
            showAlert(message: validationResponse.message)
        }
    }
    
    @IBAction func updateBtnAction(_ sender: Any) {
        Switcher.gotoUpdatePassword(delegate: self)
    }
}

extension PersonalInfoViewController: UIImagePickerControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        imagePicker.dismiss(animated: true, completion: nil)
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Image not found!")
            return
        }
        imageView.image = selectedImage
    }
}
