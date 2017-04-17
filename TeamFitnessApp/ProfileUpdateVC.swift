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

    let ref = FIRDatabase.database().reference()
    let profileUpdateView = updateProfileView()
    var firUser = FIRAuth.auth()!.currentUser
    var user: User!
    var myImage: UIImage!

    

    override func loadView() {
        
        self.view = profileUpdateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        fetchUser {
                self.populateView()
            
        }
        
        profileUpdateView.delegate = self
        self.hideKeyboardWhenTappedAround()
    }
    
    func populateView () {

        FirebaseStoreageManager.downloadImage(forUser: user) { (response) in
            
         // handle errors
            switch response {
            case let .successfulDownload(userImage):
              self.profileUpdateView.myImageView.image = userImage                //                NotificationCenter.default.post(name: .closeLoginVC, object: nil)
                
            case let .failure(failString):
                print(failString)
                self.alert(message: failString)
            default:
                print("Firebase login failure")
            }

        }
        
        let userHeightInt = Int(self.user!.height)
        let userHeightFeet = userHeightInt / 12
        let userHeightInches = userHeightInt % 12
        
        
        profileUpdateView.heightFeetTextField.text? = String(userHeightFeet)
        profileUpdateView.heightInchesTextField.text? = String(userHeightInches)
        profileUpdateView.nameTextField.text = self.user!.name
        profileUpdateView.weightTextField.text = String(describing: self.user!.weight)
        profileUpdateView.genderButton.setTitle((self.user!.sex), for: .normal)
   
    }
    
    func pressSaveButton() {
      
        guard let userHeightFeet = profileUpdateView.heightFeetTextField.text else {
            alert(message: "Please enter feet")
            return
        }
        
        guard let userHeightInches = profileUpdateView.heightInchesTextField.text else{
            alert(message: "Please enter inches")
            return
        }
        
        
        let height = Float(userHeightFeet)! + Float(userHeightInches)!
        
        guard let name = profileUpdateView.nameTextField.text else {
            alert(message: "Please enter a name.")
            return
        }
        
        guard let weightString = profileUpdateView.weightTextField.text else {
            alert(message: "Please enter a weight")
            return
        }
        let weight = Int(weightString)
       
        guard let sex = profileUpdateView.genderButton.currentTitle else {
            alert(message: "Please enter a gender")
            return
        }

        self.user?.update(name: name, weight: weight!, height: height, sex: sex)
        
        if let user = self.user {
            FirebaseManager.save(user: user) { (success) in
                if success {
                    DispatchQueue.main.async {
                        NotificationCenter.default.post(name: .closeLoginVC, object: nil)
                    }
                }
            }
        }
    }
    
  
    
    func fetchUser(completion: @escaping ()->()) {
       
        if let uid = firUser?.uid {
            FirebaseManager.fetchUser(withFirebaseUID: uid) { (returnUser) in
                
                self.user = returnUser
                completion()

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
        let userImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        profileUpdateView.myImageView.image = userImage
        profileUpdateView.myImageView.backgroundColor = UIColor.clear
        profileUpdateView.myImageView.contentMode = UIViewContentMode.scaleAspectFit
        
        
        FirebaseStoreageManager.upload(userImage: userImage!, withUserID: (self.user?.uid!)!) { (FirebaseResponse) in
            
            print("image upload complete")
            self.dismiss(animated: true, completion: nil)

            
        }
        
        navigationController?.dismiss(animated: true, completion: nil)


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
            self.user?.sex = "Male"

        }
        let femaleAction = UIAlertAction(title: "Female", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            print("ok")
            self.profileUpdateView.genderButton.setTitle("Female", for: .normal)
            self.user?.sex = "Female"
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(maleAction)
        alertController.addAction(femaleAction)
        
        
        self.present(alertController, animated: true)
        
    }
}
