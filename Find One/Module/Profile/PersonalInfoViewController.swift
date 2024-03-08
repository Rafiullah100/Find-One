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

    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet var editButtons: [UIButton]!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var updateButton: UIButton!
    
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type = .back
        viewControllerTitle = "Personal Information"
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
