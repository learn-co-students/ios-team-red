//
//  LogInView.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/7/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class LogInView: FitnessView {
    
    let fitnessBabyLabel = FitnessLabel()
    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let loginButton = FitnessButton()
    let newUserButton = FitnessButton()
    let googleButton = FitnessButton()
    let facebookButton = FitnessButton()

    override init() {
        super.init()
        loadUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadUI() {
   
        self.addSubview(fitnessBabyLabel)
        fitnessBabyLabel.translatesAutoresizingMaskIntoConstraints = false
        fitnessBabyLabel.textAlignment = NSTextAlignment.center
        fitnessBabyLabel.reverseColors()
        fitnessBabyLabel.changeFontSize(to: 32.0)
        fitnessBabyLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        fitnessBabyLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 80).isActive = true
        fitnessBabyLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true
        fitnessBabyLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        fitnessBabyLabel.text = "Fitness Baby"
    
        self.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.layer.cornerRadius = 5
        emailTextField.textAlignment = NSTextAlignment.center
        emailTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: fitnessBabyLabel.bottomAnchor, constant: 50).isActive = true
        emailTextField.placeholder = "email"
        emailTextField.backgroundColor = UIColor.white
        
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
        
       
       
        self.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true
        loginButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50).isActive = true
        loginButton.isEnabled = true
        loginButton.setTitle("Login", for: .normal)
        //        loginButton.addTarget(self, action: #selector(pressLoginButton), for: UIControlEvents.touchUpInside)
        
       
        self.addSubview(newUserButton)
        newUserButton.translatesAutoresizingMaskIntoConstraints = false
        newUserButton.setTitle("New User", for: .normal)
        newUserButton.changeFontSize(to: 20.0)
        newUserButton.reverseColors()
        newUserButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        newUserButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        newUserButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        newUserButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20).isActive = true
        newUserButton.isEnabled = true
                
        self.addSubview(googleButton)
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        googleButton.setTitle("Google", for: .normal)
        googleButton.changeFontSize(to: 16.0)
        googleButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        googleButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        googleButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        googleButton.topAnchor.constraint(equalTo: newUserButton.bottomAnchor, constant: 20).isActive = true
        
      
        self.addSubview(facebookButton)
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        facebookButton.setTitle("Facebook", for: .normal)
        facebookButton.changeFontSize(to: 16.0)
        facebookButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
        facebookButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        facebookButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        facebookButton.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 20).isActive = true
    
    }
}
