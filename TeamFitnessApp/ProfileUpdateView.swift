//
//  ProfileUpdateView.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/13/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import UIKit

protocol UpdateProfileViewDelegate: class {
//    func pressGenderButton()
    func displayImagePickerButtonTapped()
    func pressSaveButton()
}



class updateProfileView: FitnessView {
    
    var profileLabel: FitnessLabel!
    var myImageView: UIImageView!
    var showImagePickerButton: FitnessButton!
    var nameTextField: FitnessField!
    var weightTextField: FitnessField!
//    var heightFeetTextField: FitnessField!
//    var heightInchesTextField: FitnessField!
//    var genderButton: UIButton!
    var saveButton: FitnessButton!
    weak var delegate: UpdateProfileViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadProfileUpdateUI()
        setConstraints()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func pressGenderButton(sender: UIButton) {
//        delegate?.pressGenderButton()
//    }
    
    func displayImagePickerButtonTapped(sender: UIButton) {
        delegate?.displayImagePickerButtonTapped()
    }
    
    func pressSaveButton(sender:UIButton) {
        print("SaveButton")
        delegate?.pressSaveButton()
    }

  
    func loadProfileUpdateUI () {
        
        profileLabel = FitnessLabel()
        self.addSubview(profileLabel)
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        profileLabel.textAlignment = NSTextAlignment.center
        profileLabel.reverseColors()
        profileLabel.changeFontSize(to: 20.0)
        profileLabel.set(text: "Profile")

        myImageView = UIImageView()
        self.addSubview(myImageView)
        myImageView.image = #imageLiteral(resourceName: "runner2")
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        
 
        
        
        showImagePickerButton = FitnessButton()
        self.addSubview(showImagePickerButton)
        showImagePickerButton.translatesAutoresizingMaskIntoConstraints = false
        showImagePickerButton.set(text: "choose image")
    //  showImagePickerButton.backgroundColor = UIColor.clear
        showImagePickerButton.addTarget(self, action: #selector(displayImagePickerButtonTapped), for: .touchUpInside)
        
        
   
        nameTextField = FitnessField()
        self.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.autocorrectionType = .no
        nameTextField.setPlaceholder(text: "name")
        

        weightTextField = FitnessField()
        self.addSubview(weightTextField)
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        weightTextField.setPlaceholder(text: "weight")
        weightTextField.keyboardType = UIKeyboardType.numberPad
        
        saveButton = FitnessButton()
        self.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.set(text: "continue")
        saveButton.addTarget(self, action: #selector(pressSaveButton), for: UIControlEvents.touchUpInside)

        

        
    }
    
    func setConstraints() {
        
        profileLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profileLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        profileLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
        profileLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        
        myImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        myImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
        myImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2, constant: 0).isActive = true
        myImageView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 0).isActive = true
        
        showImagePickerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        showImagePickerButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
        showImagePickerButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05, constant: 0).isActive = true
        showImagePickerButton.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 50).isActive = true

        nameTextField.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 20).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        weightTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        weightTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        weightTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        weightTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
        
        saveButton.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 10).isActive = true
        saveButton.widthAnchor.constraint(equalTo: weightTextField.widthAnchor).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        saveButton.addTarget(self, action: #selector(pressSaveButton), for: UIControlEvents.touchUpInside)
    }
    
    
    



}
