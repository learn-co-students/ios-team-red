//
//  CreateNewUserViewController.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import Firebase

class NewUserViewController: UIViewController, NewUserViewDelegate, UITextFieldDelegate {
    
    var createNewUserView = NewUserView()
   
    var userEmail: String!
    var userPassword: String!
    var confirmPassword: String!
    var uid: String? = FIRAuth.auth()?.currentUser?.uid
    var googleLogin: Bool {
        return FIRAuth.auth()?.currentUser != nil
    }

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
        
        if googleLogin {
            createNewUserView.emailTextField.isUserInteractionEnabled = false
            createNewUserView.emailTextField.alpha = 0.5
            createNewUserView.emailTextField.text = FIRAuth.auth()?.currentUser?.email
            createNewUserView.passwordTextField.isHidden = true
            createNewUserView.confirmTextField.isHidden = true
        }
    
    }
    
    func pressCancelCreate() {
        let vc = LogInViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
    

    
    
    
   
    func pressProfileButton() {
        
        guard let userEmail = createNewUserView.emailTextField.text else {
            alert(message: "Please enter a valid email.")
            return
        }
        
        guard let userPassword = createNewUserView.passwordTextField.text else {
            alert(message: "Please enter a password.")
            return
        }
        
        guard let confirmPassword = createNewUserView.confirmTextField.text else {
            alert(message: "Please confirm password.")
            return
        }
        
        
        if googleLogin {
            let vc: ProfileViewController = ProfileViewController()
            vc.userEmail = self.userEmail
            vc.uid = self.uid ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        } else if checkPassword(userPassword: userPassword, confirmPassword: confirmPassword) {
            
            FirebaseManager.createNew(withEmail: userEmail, withPassword: userPassword, completion: { (response) in
                switch response {
                case let .successfulNewUser(uid):
                
                    let vc: ProfileViewController = ProfileViewController()
                    vc.userEmail = userEmail
//                    vc.userPassword = userPassword
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


