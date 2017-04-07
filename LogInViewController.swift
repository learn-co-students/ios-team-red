
//
//  ViewController.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    var logInView = FitnessView()
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadLogInViewUI()
        
    }
    
    override func loadView() {
        super.loadView()
        self.view = logInView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }

    func pressNewUserButton() {
        
        self.present(NewUserViewController(), animated: true, completion: nil)
    }

}

extension LogInViewController {
    
    func loadLogInViewUI () {
        
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
        emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: fitnessBabyLabel.bottomAnchor, constant: 50).isActive = true
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
        
        let loginButton = FitnessButton()
        self.view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.setTitle("Login", for: .normal)
        loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
        loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50).isActive = true
        loginButton.isEnabled = true
//        loginButton.addTarget(self, action: #selector(pressLoginButton), for: UIControlEvents.touchUpInside)
        
        let newUserButton = FitnessButton()
        self.view.addSubview(newUserButton)
        newUserButton.translatesAutoresizingMaskIntoConstraints = false
        newUserButton.setTitle("New User", for: .normal)
        newUserButton.changeFontSize(to: 20.0)
        newUserButton.reverseColors()
        newUserButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        newUserButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        newUserButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newUserButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20).isActive = true
        newUserButton.isEnabled = true
        newUserButton.addTarget(self, action: #selector(pressNewUserButton), for: UIControlEvents.touchUpInside)

        
        let googleButton = FitnessButton()
        self.view.addSubview(googleButton)
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        googleButton.setTitle("Google", for: .normal)
        googleButton.changeFontSize(to: 16.0)
        googleButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        googleButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        googleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        googleButton.topAnchor.constraint(equalTo: newUserButton.bottomAnchor, constant: 20).isActive = true
        
        let facebookButton = FitnessButton()
        self.view.addSubview(facebookButton)
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        facebookButton.setTitle("Facebook", for: .normal)
        facebookButton.changeFontSize(to: 16.0)
        facebookButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        facebookButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        facebookButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        facebookButton.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 20).isActive = true
    }
}
