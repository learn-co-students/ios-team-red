
//
//  ViewController.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    var myView = FitnessView()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//      FirebaseManager.generateTestData()
      
//      let screenSize = UIScreen.main.bounds
//      let screenWidth = screenSize.width
//      let screenHeight = screenSize.height
//      let x: CGFloat = 0.0
//      let y: CGFloat = 0.0//
//      let myBounds = CGRect(x: x, y: y, width: screenWidth, height: screenHeight)
//      let myView = FitnessView(frame: myBounds)
//      view.addSubview(myView)
        
        let fitnessBabyLabel = FitnessLabel()
        self.view.addSubview(fitnessBabyLabel)
        fitnessBabyLabel.translatesAutoresizingMaskIntoConstraints = false
        fitnessBabyLabel.textAlignment = NSTextAlignment.center
        fitnessBabyLabel.reverseColors()
        fitnessBabyLabel.changeFontSize(to: 32.0)
        fitnessBabyLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        fitnessBabyLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        fitnessBabyLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        fitnessBabyLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        fitnessBabyLabel.text = "Fitness Baby"
        
        let emailTextField = UITextField()
        self.view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.layer.cornerRadius = 5
        emailTextField.textAlignment = NSTextAlignment.center
        emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18)
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: fitnessBabyLabel.bottomAnchor, constant: 50).isActive = true
        emailTextField.placeholder = "email"
        emailTextField.backgroundColor = UIColor.white
        
        let passwordTextField = UITextField()
        self.view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.textAlignment = NSTextAlignment.center
        passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18)
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        passwordTextField.placeholder = "password"
        passwordTextField.backgroundColor = UIColor.white
        
        let loginButton = FitnessButton()
        self.view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
        loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50).isActive = true
        
        let newUser = FitnessButton()
        self.view.addSubview(newUser)
        newUser.translatesAutoresizingMaskIntoConstraints = false
        newUser.setTitle("New User", for: .normal)
        newUser.changeFontSize(to: 20.0)
        newUser.reverseColors()
        newUser.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        newUser.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        newUser.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newUser.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 50).isActive = true

        
        
        
        
        
    
    
    }
    
    override func loadView() {
        super.loadView()
        self.view = myView
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
}
