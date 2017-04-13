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
}



class NewUserView: FitnessView {
    

    var newUser: FitnessLabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var confirmTextField: UITextField!
    var completeCreation: FitnessLabel!
    var profileButton: FitnessButton!
    weak var delegate: NewUserViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
    func pressProfileButton(sender: UIButton) {
        delegate?.pressProfileButton()
    }

    func loadUI() {
        
    
    newUser = FitnessLabel()
    self.addSubview(newUser)
    newUser.translatesAutoresizingMaskIntoConstraints = false
    newUser.textAlignment = NSTextAlignment.center
    newUser.reverseColors()
    newUser.changeFontSize(to: 32.0)
    newUser.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    newUser.topAnchor.constraint(equalTo: self.topAnchor, constant: 40).isActive = true
    newUser.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
    newUser.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
    newUser.text = "Create New User"
    
    emailTextField = UITextField()
    self.addSubview(emailTextField)
    emailTextField.translatesAutoresizingMaskIntoConstraints = false
    emailTextField.layer.cornerRadius = 5
    emailTextField.textAlignment = NSTextAlignment.center
    emailTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
    emailTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
    emailTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    emailTextField.topAnchor.constraint(equalTo: newUser.bottomAnchor, constant: 50).isActive = true
    emailTextField.placeholder = "email"
    emailTextField.backgroundColor = UIColor.white
    
    passwordTextField = UITextField()
    self.addSubview(passwordTextField)
    passwordTextField.translatesAutoresizingMaskIntoConstraints = false
    passwordTextField.layer.cornerRadius = 5
    passwordTextField.textAlignment = NSTextAlignment.center
    passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
    passwordTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
    passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
    passwordTextField.placeholder = "password"
    passwordTextField.backgroundColor = UIColor.white
    
    confirmTextField = UITextField()
    self.addSubview(confirmTextField)
    confirmTextField.translatesAutoresizingMaskIntoConstraints = false
    confirmTextField.layer.cornerRadius = 5
    confirmTextField.textAlignment = NSTextAlignment.center
    confirmTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
    confirmTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
    confirmTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    confirmTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
    confirmTextField.placeholder = "confirm password"
    confirmTextField.backgroundColor = UIColor.white
    
    completeCreation = FitnessLabel()
    self.addSubview(completeCreation)
    completeCreation.translatesAutoresizingMaskIntoConstraints = false
    completeCreation.textAlignment = NSTextAlignment.center
    completeCreation.reverseColors()
    completeCreation.changeFontSize(to: 20.0)
    completeCreation.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    completeCreation.topAnchor.constraint(equalTo: confirmTextField.bottomAnchor, constant: 20).isActive = true
    completeCreation.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
    completeCreation.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
    completeCreation.text = "A little more info to get started!"
    
    profileButton = FitnessButton()
    self.addSubview(profileButton)
    profileButton.translatesAutoresizingMaskIntoConstraints = false
    profileButton.setTitle("Setup Profile", for: .normal)
    profileButton.changeFontSize(to: 20.0)
    profileButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
    profileButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
    profileButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    profileButton.topAnchor.constraint(equalTo: completeCreation.bottomAnchor, constant: 20).isActive = true
    profileButton.isEnabled = true
    profileButton.addTarget(self, action: #selector(pressProfileButton), for: UIControlEvents.touchUpInside)
    
    
    }
}

