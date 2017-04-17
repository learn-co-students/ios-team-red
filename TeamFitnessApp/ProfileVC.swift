//
//  ProfileView.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.


import UIKit
import Foundation

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, ProfileViewDelegate {

    let profileView = ProfileView()
    var userEmail: String!
    var userPassword: String!
    var uid: String!
    var userImage: UIImage = #imageLiteral(resourceName: "people")
    
    override func loadView() {
        self.view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        profileView.delegate = self
        self.hideKeyboardWhenTappedAround()
//        print("ProfileVC email\(userEmail)")
//        print("ProfileVC password\(userPassword)")
    
    
    }
    
    
    func setGoalsButton() {
        
        
        let weight = Int(profileView.weightTextField.text!)!
        let height = ((Float(profileView.heightFeetTextField.text!)! * 12) + (Float(profileView.heightInchesTextField.text!)!))
        let name = profileView.nameTextField.text!
        let gender = profileView.genderButton.currentTitle!
            
        let vc: GoalsViewController = GoalsViewController()
        
        vc.userEmail = userEmail
        vc.userPassword = userPassword
        vc.name = name
        vc.gender = gender
        vc.height = height
        vc.weight = weight
        vc.uid = uid
        
        print("ProfileVC email\(userEmail)")
        print("ProfileVC password\(userPassword)")
        print("ProfileVC name\(name)")
        print("ProfileVC gender\(gender)")
        print("ProfileVC height\(height)")
        print("ProfileVC weight\(weight)")
        
            
      self.navigationController?.pushViewController(vc, animated: true)
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
        profileView.myImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        profileView.myImageView.backgroundColor = UIColor.clear
        profileView.myImageView.contentMode = UIViewContentMode.scaleAspectFit
        var userImage = profileView.myImageView.image!
    
        FirebaseStoreageManager.upload(userImage: userImage, withUserID: self.uid) { (FirebaseResponse) in
            
           print("image upload complete")
        
        
        }
    
        
        
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
//            self.gender = "Male"
            self.profileView.genderButton.setTitle("Male", for: .normal)
            
        }
        let femaleAction = UIAlertAction(title: "Female", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            print("ok")
//            self.gender = "Female"
            self.profileView.genderButton.setTitle("Female", for: .normal)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(maleAction)
        alertController.addAction(femaleAction)
        

        self.present(alertController, animated: true)
        
    }

}



