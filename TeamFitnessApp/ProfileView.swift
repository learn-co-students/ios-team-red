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
    func pressCancelButton()
}

class ProfileView: FitnessView {
    
    var profileLabel: FitnessLabel!
    var myImageView: UIImageView!
    var showImagePickerButton: FitnessButton!
    var cancelButton: FitnessButton!
    var nameTextField: FitnessField!
    var weightTextField: FitnessField!
    var heightFeetTextField: FitnessField!
    var heightInchesTextField: FitnessField!
    var genderButton: UIButton!
    var setGoalsButton: FitnessButton!
    weak var delegate: ProfileViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadProfileViewUI()
        setConstraints()
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
    
    func pressCancelButton(sender:UIButton) {
        delegate?.pressCancelButton()
    }
        
    
    func loadProfileViewUI() {
        
        profileLabel = FitnessLabel()
        self.addSubview(profileLabel)
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        profileLabel.textAlignment = NSTextAlignment.center
        profileLabel.reverseColors()
        profileLabel.changeFontSize(to: 20.0)
        profileLabel.set(text: "...now lets setup your profile..")
        
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

        genderButton = UIButton(type: .custom)
        self.addSubview(genderButton)
        genderButton.translatesAutoresizingMaskIntoConstraints = false
        genderButton.backgroundColor = UIColor.reallyLightGray
        genderButton.setTitleColor(UIColor.lightGray, for: .normal)
        genderButton.layer.cornerRadius = 5
        genderButton.addTarget(self, action: #selector(pressGenderButton), for: UIControlEvents.touchUpInside)

        let genderText = "gender"
        let attributes: NSDictionary = [
          NSFontAttributeName:UIFont(name: "Fresca-Regular", size: 17)!,
          NSKernAttributeName:CGFloat(3.0),
          NSForegroundColorAttributeName:UIColor.lightGray,
          ]
        let attributedTitle = NSAttributedString(string: genderText.uppercased(), attributes:attributes as? [String : AnyObject])

        genderButton.setAttributedTitle(attributedTitle, for: .normal)

        
        heightFeetTextField = FitnessField()
        self.addSubview(heightFeetTextField)
        heightFeetTextField.translatesAutoresizingMaskIntoConstraints = false
        heightFeetTextField.setPlaceholder(text: "feet")
        heightFeetTextField.keyboardType = UIKeyboardType.numberPad
        
        heightInchesTextField = FitnessField()
        self.addSubview(heightInchesTextField)
        heightInchesTextField.translatesAutoresizingMaskIntoConstraints = false
        heightInchesTextField.setPlaceholder(text: "inches")
        heightInchesTextField.keyboardType = UIKeyboardType.numberPad
        
        setGoalsButton = FitnessButton()
        self.addSubview(setGoalsButton)
        setGoalsButton.translatesAutoresizingMaskIntoConstraints = false
        setGoalsButton.set(text: "continue")
        setGoalsButton.addTarget(self, action: #selector(pressSetGoals), for: UIControlEvents.touchUpInside)
        
        cancelButton = FitnessButton()
        self.addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        cancelButton.setReversed(text: "cancel")
        cancelButton.reverseColors()
        cancelButton.changeFontSize(to: 14.0)
        cancelButton.addTarget(self, action: #selector(pressCancelButton), for: UIControlEvents.touchUpInside)


    }


  func setConstraints() {
    profileLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    profileLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
    profileLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true

    myImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
    myImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
    myImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.2, constant: 0).isActive = true
    myImageView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 0).isActive = true

    showImagePickerButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30).isActive = true
    showImagePickerButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4, constant: 0).isActive = true
    showImagePickerButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05, constant: 0).isActive = true
    showImagePickerButton.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 50).isActive = true

    nameTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
    nameTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
    nameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    nameTextField.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 0).isActive = true

    weightTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
    weightTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
    weightTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    weightTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true

    heightFeetTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.12).isActive = true
    heightFeetTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
    heightFeetTextField.leadingAnchor.constraint(equalTo: weightTextField.leadingAnchor, constant: 0).isActive = true
    heightFeetTextField.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 15).isActive = true

    heightInchesTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.17).isActive = true
    heightInchesTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
    heightInchesTextField.trailingAnchor.constraint(equalTo: weightTextField.trailingAnchor, constant: 0).isActive = true
    heightInchesTextField.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 15).isActive = true

    genderButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
    genderButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
    genderButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    genderButton.topAnchor.constraint(equalTo: heightFeetTextField.bottomAnchor, constant: 15).isActive = true

    setGoalsButton.topAnchor.constraint(equalTo: genderButton.bottomAnchor, constant: 20).isActive = true
    setGoalsButton.widthAnchor.constraint(equalTo: genderButton.widthAnchor).isActive = true
    setGoalsButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true

    cancelButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
    cancelButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
    cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    cancelButton.topAnchor.constraint(equalTo: setGoalsButton.bottomAnchor, constant: 15).isActive = true

  }

}
