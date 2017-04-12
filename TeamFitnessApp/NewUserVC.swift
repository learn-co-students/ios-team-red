//
//  CreateNewUserViewController.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController, NewUserViewDelegate, UITextFieldDelegate {
    
    var createNewUserView = NewUserView()
   
    var userEmail: String = ""
    var userPassword: String = ""
    var confirmPassword: String = ""

    override func loadView() {
        
        self.view = createNewUserView
        createNewUserView.delegate = self
        self.hideKeyboardWhenTappedAround()
        
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createNewUserView.emailTextField.delegate = self
        createNewUserView.emailTextField.tag = 0
        createNewUserView.passwordTextField.delegate = self
        createNewUserView.passwordTextField.tag = 1
        createNewUserView.confirmTextField.delegate = self
        createNewUserView.confirmTextField.tag = 2
    
    }
    
    func checkPassword(userPassword: String, confirmPassword: String) -> Bool {
        return userPassword == confirmPassword
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textfielddidendediting")
    }
    
    //fix not working for retype password
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextField = createNewUserView.emailTextField.superview?.viewWithTag(createNewUserView.emailTextField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
            
        } else {
            createNewUserView.resignFirstResponder()
        }

        return false
    }
    
    //??????
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    
   
    func pressProfileButton() {
        
        userEmail = createNewUserView.emailTextField.text!
        userPassword = createNewUserView.passwordTextField.text!
        confirmPassword = createNewUserView.confirmTextField.text!
        
    
        if checkPassword(userPassword: userPassword, confirmPassword: confirmPassword) {
            
            FirebaseManager.createNew(withEmail: userEmail, withPassword: userPassword, completion: { (response) in
                switch response {
                case let .successfulNewUser(uid):
                
                    let vc: ProfileViewController = ProfileViewController()
                    vc.userEmail = self.userEmail
                    vc.userPassword = self.userPassword
                    vc.uid = uid
                    self.navigationController?.pushViewController(vc, animated: true)
                   
                case let .failure(error):
                    self.alert(message: error)
                default:
                    print("default")
                        
            }
        })
  
            print("New User's email\(userEmail)")
            print("New User's password\(userPassword)")
            
        } else {
            
            self.alert(message: "Passwords Don't Match")
        }
        
    }
    
    
    
}


