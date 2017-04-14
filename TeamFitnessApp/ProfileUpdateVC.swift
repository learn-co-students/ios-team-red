//
//  ProfileUpdateVC.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/13/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import Firebase

class ProfileUpdateVC: UIViewController, UpdateProfileViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    let profileUpdateView = updateProfileView()
    var user = FIRAuth.auth()!.currentUser

    //    var userName: String!
//    var userWeight: Int!
    
//    var name: String = ""
//    var userEmail: String = ""
//    var userPassword: String = ""
//    var weight: Int = 0
//    var gender: String = ""
//    var height: Float = 0
//    var uid: String = ""
//    
//    var user = User(name: "profileuname", sex: "male", height: 62, weight: 85, teamIDs: [], challengeIDs: [], goals: [], email: "fggg@ggg.com", uid: "testString")
    
    


 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchUser()
        
        profileUpdateView.delegate = self
        self.hideKeyboardWhenTappedAround()
        populateView()

        
        
        
    
    }
    
    override func loadView() {
     
        self.view = profileUpdateView
    }
    
    func populateView () {
        
        let userHeightInt = Int(user.height)
        let userHeightFeet = userHeightInt / 12
        let userHeightInches = userHeightInt % 12
        
        
        profileUpdateView.heightFeetTextField.text? = String(userHeightFeet)
        profileUpdateView.heightInchesTextField.text? = String(userHeightInches)
        profileUpdateView.nameTextField.text? = user.name
        profileUpdateView.weightTextField.text? = String(user.weight)
        profileUpdateView.genderButton.setTitle((user.sex), for: .normal)
    

    
        
        
    }
    
    func pressSaveButton() {
        
        user.name = profileUpdateView.nameTextField.text?
        
        
        
//        
//        FIRAuth.auth()!.currentUser.
//        
//        // update user
//        
        
        
    }
    
    func fetchUser() {
        if let uid = user.uid {
            FirebaseManager.fetchUser(withFirebaseUID: uid) { (user) in
                DispatchQueue.main.async {
                    self.userName = user.name
                    self.userWeight = user.weight
                }
            }
        }
        
    }

    
    func displayImagePickerButtonTapped() {
        
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        
        let selectPhotoAlert = UIAlertController(title: "Photo Source", message: "Choose a Source", preferredStyle: .actionSheet)
        
        selectPhotoAlert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                myPickerController.sourceType = .camera
                self.present(myPickerController, animated: true, completion: nil)
                
            } else {
                print("No camera")
            }
        }))
        
        selectPhotoAlert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
            myPickerController.sourceType = .photoLibrary
            self.present(myPickerController, animated: true, completion: nil)
            
        }))
        
        selectPhotoAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:  nil))
        
        self.present(selectPhotoAlert, animated: true, completion: nil)
        
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
    {
        profileUpdateView.myImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        //        userImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        profileUpdateView.myImageView.backgroundColor = UIColor.clear
        profileUpdateView.myImageView.contentMode = UIViewContentMode.scaleAspectFit
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func pressGenderButton () {
        
        let alertController = UIAlertController(title: "Gender", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
            print("Cancel")
        }
        let maleAction = UIAlertAction(title: "Male", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            print("OK")
            self.profileUpdateView.genderButton.setTitle("Male", for: .normal)

        }
        let femaleAction = UIAlertAction(title: "Female", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            print("ok")
            self.profileUpdateView.genderButton.setTitle("Female", for: .normal)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(maleAction)
        alertController.addAction(femaleAction)
        
        
        self.present(alertController, animated: true)
        
    }


    
    
    

  

}
