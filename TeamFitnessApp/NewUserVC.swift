//
//  CreateNewUserViewController.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController {
    
    var createNewUserView = FitnessView()

    override func viewDidLoad() {
        super.viewDidLoad()
        NewUserViewUI()
    }

    override func loadView() {

        self.view = createNewUserView
    }
    
    func pressProfileButton() {
        
        self.present(ProfileViewController(), animated: true, completion: nil)
    }
    
}

extension NewUserViewController {
    
    func NewUserViewUI() {
        
        let newUser = FitnessLabel()
        self.view.addSubview(newUser)
        newUser.translatesAutoresizingMaskIntoConstraints = false
        newUser.textAlignment = NSTextAlignment.center
        newUser.reverseColors()
        newUser.changeFontSize(to: 32.0)
        newUser.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newUser.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        newUser.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        newUser.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        newUser.text = "Create New User"
        
        let emailTextField = UITextField()
        self.view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.layer.cornerRadius = 5
        emailTextField.textAlignment = NSTextAlignment.center
        emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: newUser.bottomAnchor, constant: 50).isActive = true
        emailTextField.placeholder = "email"
        emailTextField.backgroundColor = UIColor.white
        
        let passwordTextField = UITextField()
        self.view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.textAlignment = NSTextAlignment.center
        passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        passwordTextField.placeholder = "password"
        passwordTextField.backgroundColor = UIColor.white
        
        let confirmTextField = UITextField()
        self.view.addSubview(confirmTextField)
        confirmTextField.translatesAutoresizingMaskIntoConstraints = false
        confirmTextField.layer.cornerRadius = 5
        confirmTextField.textAlignment = NSTextAlignment.center
        confirmTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        confirmTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        confirmTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        confirmTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20).isActive = true
        confirmTextField.placeholder = "re-type password"
        confirmTextField.backgroundColor = UIColor.white
        
        let completeCreation = FitnessLabel()
        self.view.addSubview(completeCreation)
        completeCreation.translatesAutoresizingMaskIntoConstraints = false
        completeCreation.textAlignment = NSTextAlignment.center
        completeCreation.reverseColors()
        completeCreation.changeFontSize(to: 20.0)
        completeCreation.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        completeCreation.topAnchor.constraint(equalTo: confirmTextField.bottomAnchor, constant: 20).isActive = true
        completeCreation.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        completeCreation.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        completeCreation.text = "Almost done!"
        
        let profileButton = FitnessButton()
        self.view.addSubview(profileButton)
        profileButton.translatesAutoresizingMaskIntoConstraints = false
        profileButton.setTitle("Setup Profile", for: .normal)
        profileButton.changeFontSize(to: 20.0)
        profileButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        profileButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        profileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileButton.topAnchor.constraint(equalTo: completeCreation.bottomAnchor, constant: 20).isActive = true
        profileButton.isEnabled = true
        profileButton.addTarget(self, action: #selector(pressProfileButton), for: UIControlEvents.touchUpInside)
        
        
    }
    
}
