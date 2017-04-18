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


    var uid: String? = FIRAuth.auth()?.currentUser?.uid
    var thirdPartyLogin: Bool {
        print("USER ALREADY LOGGED IN \(FIRAuth.auth()?.currentUser?.uid)")
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
        createNewUserView.confirmTextField.returnKeyType = .go
        
        print("CREATE NEW USER CHECK FOR AUTHORIZATION ALREADY EXISTING")
        if thirdPartyLogin {//if someone has logged in via facebook or google or already created an email Firebase auth
            print("SOMEONE HAS LOGGED IN WITH A PREVIOUS EMAIL OR GOOGLE/FACEBOOK")
            createNewUserView.passwordTextField.isHidden = true //remove password text fields
            createNewUserView.confirmTextField.isHidden = true
            if FIRAuth.auth()?.currentUser?.email != nil { //check if facebook or google provided a valid email
                print("VALID EMAIL, SHOULD PUSH TO PROFILE VIEW CONTROLLER")
                createNewUserView.emailTextField.text = FIRAuth.auth()?.currentUser?.email//if so, fill out email field and remove user interaction
                createNewUserView.emailTextField.isUserInteractionEnabled = false
                createNewUserView.emailTextField.alpha = 0.5
                let vc: ProfileViewController = ProfileViewController() //then push to the next VC
                vc.userEmail = createNewUserView.emailTextField.text
                vc.userPassword = ""
                vc.uid = uid
                print("PUSH TO PROFILE VIEW CONTROLLER********************************")
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    
    }
    
    func pressCancelCreate() {
        self.navigationController?.popViewController(animated: true)
        if FIRAuth.auth()?.currentUser != nil {
            FirebaseManager.logoutUser(completion: { (response) in
                switch response {
                case .successfulLogout(let logString):
                    print(logString)
                case .failure(let failString):
                    print(failString)
                default:
                    print("invalid FirebaseManager response")
                }
            })
        }
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

      if textField == createNewUserView.passwordTextField {
        if let nextField = createNewUserView.passwordTextField.superview?.viewWithTag(createNewUserView.passwordTextField.tag + 1) as? UITextField {
          nextField.becomeFirstResponder()
        }
      }

      if textField == createNewUserView.confirmTextField {
        pressProfileButton()
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
        
        
       
        if thirdPartyLogin {

            let vc: ProfileViewController = ProfileViewController()
            vc.userEmail = userEmail
            vc.uid = self.uid ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        } else if checkPassword(userPassword: userPassword, confirmPassword: confirmPassword) {
            FirebaseManager.createNew(withEmail: userEmail, withPassword: userPassword, completion: { (response) in
                switch response {
                case let .successfulNewUser(uid):
                
                    let vc: ProfileViewController = ProfileViewController()
                    vc.userEmail = userEmail
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


