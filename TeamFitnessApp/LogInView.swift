//
//  LogInView.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/7/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit

protocol LoginViewDelegate: class {
    func pressNewUser()
    func pressLogin()
    func pressForgot()
}


class LogInView: FitnessView {

    let healthKitManager = HealthKitManager.sharedInstance
    var fitnessBabyLabel: FitnessLabel!
    var emailTextField: FitnessField!
    var passwordTextField: FitnessField!
    var loginButton: FitnessButton!
    var newUserButton: FitnessButton!
    var googleButton: GIDSignInButton!
    var facebookButton: FBSDKLoginButton!
    var forgotButton: FitnessButton!
    var imageViewDude: UIImageView!
    var imageViewLady: UIImageView!

    weak var delegate: LoginViewDelegate?


    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pressNewUser(sender: UIButton) {
        delegate?.pressNewUser()
    }

    
    func pressLogin(sender: UIButton) {
        delegate?.pressLogin()
    }

    func pressForgot(sender: UIButton) {
        delegate?.pressForgot()
    }
    
    private func loadUI() {

        imageViewDude = UIImageView(image: #imageLiteral(resourceName: "runner1"))
        imageViewDude.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageViewDude)

        imageViewLady = UIImageView(image: #imageLiteral(resourceName: "runner2"))
        imageViewLady.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imageViewLady)


        fitnessBabyLabel = FitnessLabel()
        self.addSubview(fitnessBabyLabel)
        fitnessBabyLabel.translatesAutoresizingMaskIntoConstraints = false
        fitnessBabyLabel.textAlignment = NSTextAlignment.center
        fitnessBabyLabel.reverseColors()
        fitnessBabyLabel.changeFontSize(to: 32.0)
        fitnessBabyLabel.set(text: "Fitness Baby")




        setupTextFields()
        setupFitnessButtons()
        setConstaints()
    }
    
    private func setupTextFields() {
        
        emailTextField = FitnessField()
        self.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.setPlaceholder(text: "email")
        emailTextField.clearButtonMode = .whileEditing
        emailTextField.autocorrectionType = UITextAutocorrectionType.no
        emailTextField.autocapitalizationType = .none

        passwordTextField = FitnessField()
        self.addSubview(passwordTextField)
        passwordTextField.autocorrectionType = .no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.setPlaceholder(text: "password")
        passwordTextField.autocorrectionType = UITextAutocorrectionType.no
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        emailTextField.clearButtonMode = .whileEditing


        
    }
    
    private func setupFitnessButtons() {
        
        forgotButton = FitnessButton()
        self.addSubview(forgotButton)
        forgotButton.translatesAutoresizingMaskIntoConstraints = false
        forgotButton.reverseColors()
        forgotButton.setReversed(text: "forgot password?")
        forgotButton.addTarget(self, action: #selector(pressForgot(sender:)), for: .touchUpInside)
        
        loginButton = FitnessButton()
        self.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.isEnabled = true
        loginButton.set(text: "login")
        loginButton.addTarget(self, action: #selector(pressLogin), for: .touchUpInside)

        
        newUserButton = FitnessButton()
        self.addSubview(newUserButton)
        newUserButton.translatesAutoresizingMaskIntoConstraints = false
        newUserButton.set(text: "create")
        newUserButton.changeFontSize(to: 20.0)
        newUserButton.isEnabled = true
        newUserButton.addTarget(self, action: #selector(pressNewUser), for: .touchUpInside)
        
        googleButton = GIDSignInButton()
        self.addSubview(googleButton)
        googleButton.style = .wide
        googleButton.colorScheme = .dark
        googleButton.translatesAutoresizingMaskIntoConstraints = false

        
        facebookButton = FBSDKLoginButton()
        self.addSubview(facebookButton)
        facebookButton.translatesAutoresizingMaskIntoConstraints = false

        
    }


  func setConstaints() {

    imageViewDude.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -20).isActive = true
    imageViewDude.heightAnchor.constraint(equalToConstant: 163).isActive = true
    imageViewDude.widthAnchor.constraint(equalToConstant: 105).isActive = true
    imageViewDude.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true

    imageViewLady.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 50).isActive = true
    imageViewLady.heightAnchor.constraint(equalToConstant: 117).isActive = true
    imageViewLady.widthAnchor.constraint(equalToConstant: 132).isActive = true
    imageViewLady.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true

    fitnessBabyLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    fitnessBabyLabel.topAnchor.constraint(equalTo: imageViewDude.bottomAnchor, constant: 20).isActive = true

    emailTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
    emailTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
    emailTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    emailTextField.topAnchor.constraint(equalTo: fitnessBabyLabel.bottomAnchor, constant: 20).isActive = true

    passwordTextField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
    passwordTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
    passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true

    forgotButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 0).isActive = true
    forgotButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
    forgotButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor, constant: 0).isActive = true

    loginButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    loginButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    loginButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -75).isActive = true
    loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40).isActive = true

    newUserButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    newUserButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    newUserButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 75).isActive = true
    newUserButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 40).isActive = true

//    googleButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
//    googleButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    googleButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    googleButton.topAnchor.constraint(equalTo: newUserButton.bottomAnchor, constant: 20).isActive = true

//    facebookButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
//    facebookButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
    facebookButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    facebookButton.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 20).isActive = true

  }




}

