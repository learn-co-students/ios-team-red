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
    
    var name: String!
    var userEmail: String!
    var userPassword: String!
    var weight: Int = 0
    var gender: String = ""
    var height: Int = 0
//    var userImage: UImage!
    
    override func loadView() {
        self.view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        profileView.delegate = self
        self.hideKeyboardWhenTappedAround()
        print(userEmail)
    
    }
    
    func setGoalsButton() {
        
        
        weight = Int(profileView.weightTextField.text!)!
        
        height = ((Int(profileView.heightFeetTextField.text!)! * 12) + (Int(profileView.heightInchesTextField.text!)!))
            
        let vc: GoalsViewController = GoalsViewController()
        
        vc.userEmail = userEmail
        vc.userPassword = userPassword
        vc.name = name
        vc.gender = gender
        vc.height = height
        vc.weight = weight
            
        self.present(vc, animated: true, completion: nil)
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
//        userImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        profileView.myImageView.backgroundColor = UIColor.clear
        profileView.myImageView.contentMode = UIViewContentMode.scaleAspectFit
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
            self.gender = "Male"
            
        }
        let femaleAction = UIAlertAction(title: "Female", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            print("ok")
            self.gender = "Female"
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(maleAction)
        alertController.addAction(femaleAction)
        

        self.present(alertController, animated: true)
        
    }

}



