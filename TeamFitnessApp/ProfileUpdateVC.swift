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
    var user: User?
    var myImage: UIImage!
//    var firstGoal = Goal(type: .exerciseMinutes, value: 0)
//    var secondGoal = Goal(type: .caloriesBurned, value: 0)
//    var firstGoalValue: Double!
    
    
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
        
        FirebaseStoreageManager.downloadImage(forUser: user!) { (response) in
            
            // handle errors
            switch response {
            case let .successfulDownload(userImage):
                print("userImages orientation is", userImage.imageOrientation.rawValue)
//                var image: UIImage
//                if userImage.imageOrientation != .down {
//                image = UIImage(cgImage: userImage.cgImage!, scale: userImage.scale, orientation: .down)
//                } else {
//                    image = userImage
//                }
                self.profileUpdateView.myImageView.image = userImage
                
            case let .failure(failString):

                 self.profileUpdateView.myImageView.image = #imageLiteral(resourceName: "runner2")

            default:
                print("Firebase login failure")
            }
            
        }
        
        if let user = user {
            
            profileUpdateView.nameTextField.text = user.name
            profileUpdateView.weightTextField.text = String(describing: user.weight)
            profileUpdateView.activityMinutesADay.text = String(Int(user.goals[1].value))
            profileUpdateView.caloriesADay.text = String(Int(user.goals[0].value))
        }
    }
    
    
    func pressLogOutButton() {
    
        FirebaseManager.logoutUser { (FirebaseResponse) in
            print("LogOutButton")
            NotificationCenter.default.post(name: .closeDashboardVC, object: nil)

        }
    
    }
  


    func pressSaveButton() {
      
        guard let name = profileUpdateView.nameTextField.text else {
            alert(message: "Please enter a name")
            return
        }
        
        guard profileUpdateView.nameTextField.text != "" else {

            alert(message: "Please enter a name")
            return
        }
        
        guard let weightString = profileUpdateView.weightTextField.text else {
            
            alert(message: "Please enter a weight")
            return
        }
        guard let weight = Int(weightString) else {
            alert(message: "Please enter a weight")
            return
        }
        
        guard let firstGoalValue = Double(profileUpdateView.activityMinutesADay.text!) else {
            alert(message: "Please set a daily activity goal")
            return
        }
        
        guard let secondGoalValue = Double(profileUpdateView.caloriesADay.text!) else {
            alert(message: "Please set a daily calorie goal")
            return
        }
        
        let firstGoal = Goal(type: .exerciseMinutes, value: firstGoalValue)
        let secondGoal = Goal(type: .caloriesBurned, value: secondGoalValue)
        
        self.user?.update(name: name, weight: weight, goals: [firstGoal, secondGoal])
        
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
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        
        profileUpdateView.myImageView.image = image
        profileUpdateView.myImageView.backgroundColor = UIColor.clear
        profileUpdateView.myImageView.contentMode = UIViewContentMode.scaleAspectFit
    
        FirebaseStoreageManager.upload(userImage: image, withUserID: (self.user?.uid!)!) { (FirebaseResponse) in
            print("image upload complete")
            self.dismiss(animated: true, completion: nil)
        }
        
        navigationController?.dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    

  }
