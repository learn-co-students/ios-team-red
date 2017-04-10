//
//  ProfileView.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.


import UIKit


class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

   
    let profileView = FitnessView()
    
    var profileLabel: FitnessLabel!
    var myImageView: UIImageView!
    var showImagePickerButton: UIButton!
    let nameTextField = UITextField()
    let weightTextField = UITextField()
    let heightFeetTextField = UITextField()
    let heightInchesTextField = UITextField()
    let genderButton = FitnessButton()

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
        loadProfileViewControllerUI()
        
//        setupImagePickerButton()
        
//        setupImageView()

    }
    
  
    
    override func loadView() {
        //        super.loadView()
        self.view = profileView
    }
    
   
    
    func displayImagePickerButtonTapped(_ sender:UIButton!) {
        
        
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
        myImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        myImageView.backgroundColor = UIColor.clear
        myImageView.contentMode = UIViewContentMode.scaleAspectFit
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
        }
        let femaleAction = UIAlertAction(title: "Female", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            print("ok")
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(maleAction)
        alertController.addAction(femaleAction)
        

        self.present(alertController, animated: true)
        
    }

}


extension ProfileViewController {
    
    func loadProfileViewControllerUI() {
       
        profileLabel = FitnessLabel()
        self.view.addSubview(profileLabel)
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        profileLabel.textAlignment = NSTextAlignment.center
        profileLabel.reverseColors()
        profileLabel.changeFontSize(to: 32.0)
        profileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        profileLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        profileLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        profileLabel.text = "Profile"
        
        myImageView = UIImageView()
        self.view.addSubview(myImageView)
        myImageView.image = #imageLiteral(resourceName: "runner2")
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        myImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
        myImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3, constant: 0).isActive = true
        myImageView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 0).isActive = true
        
        
        showImagePickerButton = UIButton()
        self.view.addSubview(showImagePickerButton)
        showImagePickerButton.translatesAutoresizingMaskIntoConstraints = false
        showImagePickerButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        showImagePickerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
        showImagePickerButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05, constant: 0).isActive = true
        showImagePickerButton.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 50).isActive = true
        showImagePickerButton.setTitle("Choose Image", for: UIControlState.normal)
        showImagePickerButton.backgroundColor = UIColor.lightGray
        showImagePickerButton.addTarget(self, action: #selector(ProfileViewController.displayImagePickerButtonTapped(_:)), for: .touchUpInside)

        
        self.view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.layer.cornerRadius = 5
        nameTextField.textAlignment = NSTextAlignment.center
        nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 0).isActive = true
        nameTextField.placeholder = "Name"
        nameTextField.backgroundColor = UIColor.white
        
     
        self.view.addSubview(weightTextField)
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        weightTextField.layer.cornerRadius = 5
        weightTextField.textAlignment = NSTextAlignment.center
        weightTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        weightTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        weightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weightTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
        weightTextField.placeholder = "Weight"
        weightTextField.backgroundColor = UIColor.white
        
        
     
        self.view.addSubview(heightFeetTextField)
        heightFeetTextField.translatesAutoresizingMaskIntoConstraints = false
        heightFeetTextField.layer.cornerRadius = 5
        heightFeetTextField.textAlignment = NSTextAlignment.center
        heightFeetTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
        heightFeetTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        heightFeetTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        heightFeetTextField.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 50).isActive = true
        heightFeetTextField.placeholder = "Feet"
        heightFeetTextField.backgroundColor = UIColor.white
        
        
        self.view.addSubview(heightInchesTextField)
        heightInchesTextField.translatesAutoresizingMaskIntoConstraints = false
        heightInchesTextField.layer.cornerRadius = 5
        heightInchesTextField.textAlignment = NSTextAlignment.center
        heightInchesTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
        heightInchesTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        heightInchesTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 30).isActive = true
        heightInchesTextField.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 50).isActive = true
        heightInchesTextField.placeholder = "Inches"
        heightInchesTextField.backgroundColor = UIColor.white
        
     
        self.view.addSubview(genderButton)
        genderButton.translatesAutoresizingMaskIntoConstraints = false
        genderButton.setTitle("Gender", for: .normal)
        genderButton.changeFontSize(to: 16.0)
        genderButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        genderButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        genderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        genderButton.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 20).isActive = true
        genderButton.addTarget(self, action: #selector(pressGenderButton), for: UIControlEvents.touchUpInside)

    }
}
