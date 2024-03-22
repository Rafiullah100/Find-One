//
//  ProfileViewModel.swift
//  Qaaren
//
//  Created by MacBook Pro on 12/19/23.
//

import Foundation
import UIKit
class ProfileViewModel {
    
    var myProfile: Observable<ProfileModel> = Observable(nil)
    var errorMessage: Observable<String> = Observable("")
    var parameters: [String: Any]?
    var editProfile: Observable<EditProfileModel> = Observable(nil)
//    var deleteAccount: Observable/*<DeleteModel>*/ = Observable(nil)

    func getMyProfile(){
        URLSession.shared.request(route: .myProfile, method: .get, parameters: [:], model: ProfileModel.self) { result in
            switch result {
            case .success(let myProfile):
                print(myProfile)
                self.myProfile.value = myProfile
                self.saveUser()
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    func getName() -> String {
        return myProfile.value?.user?.name ?? ""
    }
    
    func getEmail() -> String {
        return myProfile.value?.user?.email ?? ""
    }
    
    func getMobile() -> String {
        return myProfile.value?.user?.mobileNo ?? ""
    }
    
    func getImage() -> String {
        return myProfile.value?.user?.profileImage ?? ""
    }
    
    func getCountry() -> String {
        return myProfile.value?.user?.country ?? ""
    }
    
    func getCity() -> String {
        return myProfile.value?.user?.city ?? ""
    }
    
    func getAbout() -> String {
        return myProfile.value?.user?.about ?? ""
    }
    
    func getGender() -> String {
        return myProfile.value?.user?.gender ?? ""
    }
    
    func isFormValid(user: EditProfileInputModel) -> ValidationResponse {
        if user.name.isEmpty || user.email.isEmpty || user.mobile.isEmpty || user.image == nil || user.city.isEmpty || user.country.isEmpty || user.gender.isEmpty || user.about.isEmpty{
            return ValidationResponse(isValid: false, message: "Please fill all field and try again!")
        }
        else if !Helper.isValidEmail(email: user.email){
            return ValidationResponse(isValid: false, message: "Please enter a valid email!")
        }
        else{
            print(user)
            parameters = ["name": user.name, "email": user.email, "contact_no": user.mobile, "profile": user.image ?? UIImage(), "country": user.country, "city": user.city, "gender": user.gender, "about": user.about]
            return ValidationResponse(isValid: true, message: "")
        }
    }
    
    func updateProfile(image: UIImage)  {
        Networking.shared.updateProfile(route: .updateProfile, imageParameter: "profile_image", image: image, parameters: parameters ?? [:]) { result in
            switch result {
            case .success(let profile):
                print(profile)
                self.editProfile.value = profile
//                self.saveUser()
            case .failure(let error):
                self.errorMessage.value = error.localizedDescription
            }
        }
    }
//    
    func delete(){
//        URLSession.shared.request(route: .deleteAccount, method: .post, parameters: ["uuid": UserDefaults.standard.uuid], model: DeleteModel.self) { result in
//            switch result {
//            case .success(let delete):
//                self.deleteAccount.value = delete
//            case .failure(let error):
//                self.errorMessage.value = error.localizedDescription
//            }
//        }
    }
    
    private func saveUser(){
        UserDefaults.standard.profileImage = self.myProfile.value?.user?.profileImage
        UserDefaults.standard.email = self.myProfile.value?.user?.email
        UserDefaults.standard.name = self.myProfile.value?.user?.name
    }
}
