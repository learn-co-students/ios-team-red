//
//  ProfileView.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/10/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//
import UIKit
import Foundation

protocol ProfileViewDelegate: class {
    func pressGenderButton()
    func displayImagePickerButtonTapped()
    func setGoalsButton()
}

class ProfileView: FitnessView {
    
    var profileLabel: FitnessLabel!
    var myImageView: UIImageView!
    var showImagePickerButton: UIButton!
    var nameTextField: UITextField!
    var weightTextField: UITextField!
    var heightFeetTextField: UITextField!
    var heightInchesTextField: UITextField!
    var genderButton: FitnessButton!
    var setGoalsButton: FitnessButton!
    weak var delegate: ProfileViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadProfileViewUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pressGenderButton(sender: UIButton) {
        delegate?.pressGenderButton()
    }
    
    func displayImagePickerButtonTapped(sender: UIButton) {
        delegate?.displayImagePickerButtonTapped()
    }
    
    func pressSetGoals(sender:UIButton) {
        print("pressedSetGoals")
        delegate?.setGoalsButton()
    }
        
    
    func loadProfileViewUI() {
        
        profileLabel = FitnessLabel()
        self.addSubview(profileLabel)
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        profileLabel.textAlignment = NSTextAlignment.center
        profileLabel.reverseColors()
        profileLabel.changeFontSize(to: 32.0)
        profileLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profileLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        profileLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
        profileLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        profileLabel.text = "Profile"
        
        myImageView = UIImageView()
        self.addSubview(myImageView)
        myImageView.image = #imageLiteral(resourceName: "runner2")
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        myImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        myImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
        myImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2, constant: 0).isActive = true
        myImageView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 0).isActive = true
        
        
        showImagePickerButton = UIButton()
        self.addSubview(showImagePickerButton)
        showImagePickerButton.translatesAutoresizingMaskIntoConstraints = false
        showImagePickerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        showImagePickerButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
        showImagePickerButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05, constant: 0).isActive = true
        showImagePickerButton.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 50).isActive = true
        showImagePickerButton.setTitle("Choose Image", for: UIControlState.normal)
        showImagePickerButton.backgroundColor = UIColor.lightGray
        showImagePickerButton.addTarget(self, action: #selector(displayImagePickerButtonTapped), for: .touchUpInside)
        
        
        nameTextField = UITextField()
        self.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.layer.cornerRadius = 5
        nameTextField.textAlignment = NSTextAlignment.center
        nameTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 0).isActive = true
        nameTextField.placeholder = "Name"
        nameTextField.backgroundColor = UIColor.white
        
        weightTextField = UITextField()
        self.addSubview(weightTextField)
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        weightTextField.layer.cornerRadius = 5
        weightTextField.textAlignment = NSTextAlignment.center
        weightTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        weightTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        weightTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        weightTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
        weightTextField.placeholder = "Weight"
        weightTextField.backgroundColor = UIColor.white
        
        genderButton = FitnessButton()
        self.addSubview(genderButton)
        genderButton.translatesAutoresizingMaskIntoConstraints = false
        genderButton.setTitle("Gender", for: .normal)
        genderButton.changeFontSize(to: 16.0)
        genderButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        genderButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        genderButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        genderButton.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 10).isActive = true
        genderButton.addTarget(self, action: #selector(pressGenderButton), for: UIControlEvents.touchUpInside)
        
        heightFeetTextField = UITextField()
        self.addSubview(heightFeetTextField)
        heightFeetTextField.translatesAutoresizingMaskIntoConstraints = false
        heightFeetTextField.layer.cornerRadius = 5
        heightFeetTextField.textAlignment = NSTextAlignment.center
        heightFeetTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.12).isActive = true
        heightFeetTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        heightFeetTextField.leadingAnchor.constraint(equalTo: weightTextField.leadingAnchor, constant: 0).isActive = true
        heightFeetTextField.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 50).isActive = true
        heightFeetTextField.placeholder = "Feet"
        heightFeetTextField.backgroundColor = UIColor.white
        heightFeetTextField.keyboardType = UIKeyboardType.numberPad
        
        heightInchesTextField = UITextField()
        self.addSubview(heightInchesTextField)
        heightInchesTextField.translatesAutoresizingMaskIntoConstraints = false
        heightInchesTextField.layer.cornerRadius = 5
        heightInchesTextField.textAlignment = NSTextAlignment.center
        heightInchesTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15).isActive = true
        heightInchesTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        heightInchesTextField.trailingAnchor.constraint(equalTo: weightTextField.trailingAnchor, constant: 0).isActive = true
        heightInchesTextField.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 50).isActive = true
        heightInchesTextField.placeholder = "Inches"
        heightInchesTextField.backgroundColor = UIColor.white
        heightFeetTextField.keyboardType = UIKeyboardType.numberPad
        
        setGoalsButton = FitnessButton()
        self.addSubview(setGoalsButton)
        setGoalsButton.translatesAutoresizingMaskIntoConstraints = false
        setGoalsButton.setTitle("Set Goals", for: UIControlState.normal)
        setGoalsButton.topAnchor.constraint(equalTo: heightFeetTextField.bottomAnchor, constant: 10).isActive = true
        setGoalsButton.widthAnchor.constraint(equalTo: genderButton.widthAnchor).isActive = true
        setGoalsButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        setGoalsButton.addTarget(self, action: #selector(pressSetGoals), for: UIControlEvents.touchUpInside)

    }

}
