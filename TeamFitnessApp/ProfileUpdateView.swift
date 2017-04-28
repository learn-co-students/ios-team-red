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

    func displayImagePickerButtonTapped()
    func pressSaveButton()
    func pressLogOutButton()
}



class updateProfileView: FitnessView {

    var profileLabel: FitnessLabel!
    var myImageView: UIImageView!
    var showImagePickerButton: FitnessButton!
    var nameLabel: FitnessLabel!
    var nameTextField: FitnessField!
    var weightLabel: FitnessLabel!
    var weightTextField: FitnessField!
    var minuteLabel: FitnessLabel!
    var activityMinutesADay: FitnessField!
    var calorieLabel: FitnessLabel!
    var caloriesADay: FitnessField!
    var saveButton: FitnessButton!
    var logOutButton: FitnessButton!
    weak var delegate: UpdateProfileViewDelegate?


    override init(frame: CGRect) {
        super.init(frame: frame)
        loadProfileUpdateUI()
        setConstraints()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    func displayImagePickerButtonTapped(sender: UIButton) {
        delegate?.displayImagePickerButtonTapped()
    }

    func pressSaveButton(sender:UIButton) {
        print("SaveButton")
        delegate?.pressSaveButton()
    }

    func pressLogOutButton(sender:UIButton) {
        delegate?.pressLogOutButton()
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
        myImageView.layer.cornerRadius = 10
        myImageView.layer.masksToBounds = true


        showImagePickerButton = FitnessButton()
        self.addSubview(showImagePickerButton)
        showImagePickerButton.translatesAutoresizingMaskIntoConstraints = false
        showImagePickerButton.set(text: "choose image")
        //  showImagePickerButton.backgroundColor = UIColor.clear
        showImagePickerButton.addTarget(self, action: #selector(displayImagePickerButtonTapped), for: .touchUpInside)

        nameLabel = FitnessLabel()
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.textAlignment = NSTextAlignment.center
        nameLabel.numberOfLines = 3
        nameLabel.reverseColors()
        nameLabel.changeFontSize(to: 10.0)
        nameLabel.set(text: "name")

        nameTextField = FitnessField()
        self.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.clearButtonMode = .whileEditing
        nameTextField.autocorrectionType = .no
        nameTextField.setPlaceholder(text: "name")

        weightLabel = FitnessLabel()
        self.addSubview(weightLabel)
        weightLabel.translatesAutoresizingMaskIntoConstraints = false
        weightLabel.textAlignment = NSTextAlignment.center
        weightLabel.numberOfLines = 3
        weightLabel.reverseColors()
        weightLabel.changeFontSize(to: 10.0)
        weightLabel.set(text: "weight")

        weightTextField = FitnessField()
        self.addSubview(weightTextField)
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        weightTextField.setPlaceholder(text: "weight")
        weightTextField.keyboardType = UIKeyboardType.numberPad

        minuteLabel = FitnessLabel()
        self.addSubview(minuteLabel)
        minuteLabel.translatesAutoresizingMaskIntoConstraints = false
        minuteLabel.textAlignment = NSTextAlignment.center
        minuteLabel.numberOfLines = 3
        minuteLabel.reverseColors()
        minuteLabel.changeFontSize(to: 10.0)
        minuteLabel.set(text: "set daily activity goal")

        activityMinutesADay = FitnessField()
        self.addSubview(activityMinutesADay)
        activityMinutesADay.translatesAutoresizingMaskIntoConstraints = false
        activityMinutesADay.setPlaceholder(text: "active minutes")


        calorieLabel = FitnessLabel()
        self.addSubview(calorieLabel)
        calorieLabel.translatesAutoresizingMaskIntoConstraints = false
        calorieLabel.textAlignment = NSTextAlignment.center
        calorieLabel.reverseColors()
        calorieLabel.numberOfLines = 2
        calorieLabel.changeFontSize(to: 10.0)
        calorieLabel.set(text: "set daily calorie goal")


        caloriesADay = FitnessField()
        self.addSubview(caloriesADay)
        caloriesADay.translatesAutoresizingMaskIntoConstraints = false
        caloriesADay.setPlaceholder(text: "calories")


        saveButton = FitnessButton()
        self.addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.set(text: "update")
        saveButton.addTarget(self, action: #selector(pressSaveButton), for: UIControlEvents.touchUpInside)

        logOutButton = FitnessButton()
        self.addSubview(logOutButton)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.set(text: "Log Out")
        logOutButton.addTarget(self, action: #selector(pressLogOutButton), for: UIControlEvents.touchUpInside)





    }

    func setConstraints() {

        profileLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profileLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        profileLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
        profileLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true

        myImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        myImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.35, constant: 0).isActive = true
        myImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15, constant: 0).isActive = true
        myImageView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 0).isActive = true

        showImagePickerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
        showImagePickerButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
        showImagePickerButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05, constant: 0).isActive = true
        showImagePickerButton.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 30).isActive = true

        nameLabel.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 0).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        //        nameLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true



        nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 0).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

        weightLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
        weightLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        //        weightLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        weightLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true


        weightTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        weightTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        weightTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        weightTextField.topAnchor.constraint(equalTo: weightLabel.bottomAnchor, constant: 0).isActive = true

        minuteLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        minuteLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
        minuteLabel.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 10).isActive = true

        activityMinutesADay.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        activityMinutesADay.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        activityMinutesADay.topAnchor.constraint(equalTo: minuteLabel.bottomAnchor, constant: 0).isActive = true
        activityMinutesADay.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true

        calorieLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        calorieLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
        calorieLabel.topAnchor.constraint(equalTo: activityMinutesADay.bottomAnchor, constant: 10).isActive = true

        caloriesADay.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        caloriesADay.topAnchor.constraint(equalTo: calorieLabel.bottomAnchor, constant: 0).isActive = true
        caloriesADay.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        caloriesADay.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true

        saveButton.topAnchor.constraint(equalTo: caloriesADay.bottomAnchor, constant: 10).isActive = true
        saveButton.widthAnchor.constraint(equalTo: weightTextField.widthAnchor).isActive = true
        saveButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        //        saveButton.addTarget(self, action: #selector(pressSaveButton), for: UIControlEvents.touchUpInside)

        logOutButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 10).isActive = true
        logOutButton.widthAnchor.constraint(equalTo: weightTextField.widthAnchor).isActive = true
        logOutButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
}
