//
//  NewUserView.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/10/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import UIKit
import Firebase


protocol NewUserViewDelegate: class {
    func pressProfileButton()
    func pressCancelCreate()
}



class NewUserView: FitnessView {


    var newUser: FitnessLabel!
    var emailTextField: FitnessField!
    var passwordTextField: FitnessField!
    var confirmTextField: FitnessField!
    var cancelCreateButton: FitnessButton!
    var completeCreation: FitnessLabel!
    var profileButton: FitnessButton!
    weak var delegate: NewUserViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
        setConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func pressProfileButton(sender: UIButton) {
        delegate?.pressProfileButton()
    }

    func pressCancelCreate(sender: UIButton) {
        delegate?.pressCancelCreate()
    }

    func loadUI() {


        newUser = FitnessLabel()
        self.addSubview(newUser)
        newUser.translatesAutoresizingMaskIntoConstraints = false
        newUser.textAlignment = NSTextAlignment.center
        newUser.set(text: "Let's start with the basics...")
        newUser.changeFontSize(to: 20.0)


        emailTextField = FitnessField()
        self.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.autocorrectionType = .no
        emailTextField.autocapitalizationType = .none
        emailTextField.clearButtonMode = .whileEditing
        emailTextField.setPlaceholder(text: "email")

        passwordTextField = FitnessField()
        self.addSubview(passwordTextField)
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.clearButtonMode = .whileEditing
        passwordTextField.setPlaceholder(text: "password")

        confirmTextField = FitnessField()
        self.addSubview(confirmTextField)
        confirmTextField.autocorrectionType = .no
        confirmTextField.autocapitalizationType = .none
        confirmTextField.isSecureTextEntry = true
        confirmTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmTextField.clearButtonMode = .whileEditing
        confirmTextField.setPlaceholder(text: "confirm password")

        cancelCreateButton = FitnessButton()
        self.addSubview(cancelCreateButton)
        cancelCreateButton.translatesAutoresizingMaskIntoConstraints = false
        cancelCreateButton.setReversed(text: "cancel")
        cancelCreateButton.reverseColors()
        cancelCreateButton.addTarget(self, action: #selector(pressCancelCreate), for: UIControlEvents.touchUpInside)

        profileButton = FitnessButton()
        self.addSubview(profileButton)
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        profileButton.set(text: "continue")
        profileButton.changeFontSize(to: 20.0)
        profileButton.isEnabled = true
        profileButton.addTarget(self, action: #selector(pressProfileButton), for: UIControlEvents.touchUpInside)


    }


    func setConstraints() {

        newUser.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        newUser.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
        newUser.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true

        emailTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: newUser.bottomAnchor, constant: 30).isActive = true

        passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true

        confirmTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        confirmTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        confirmTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        confirmTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true

        profileButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        profileButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        profileButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        profileButton.topAnchor.constraint(equalTo: confirmTextField.bottomAnchor, constant: 20).isActive = true
        
        cancelCreateButton.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 20).isActive = true
        cancelCreateButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        cancelCreateButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true
        
    }
}

