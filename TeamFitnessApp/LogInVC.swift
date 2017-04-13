
//
//  ViewController.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, LoginViewDelegate, UITextFieldDelegate{
    
    let logInView = LogInView()
    let healthKitManager = HealthKitManager.sharedInstance
    
    override func loadView() {
        self.view = logInView
    
        logInView.emailTextField.delegate = self
        logInView.emailTextField.tag = 0
        logInView.passwordTextField.delegate = self
        logInView.passwordTextField.tag = 1
        
        self.hideKeyboardWhenTappedAround()

    }
    
    
    // textbox return changes field form email to password  ++
    
    // turn off auto correct ++ set in view
    
    // pressing off field lowers textbox  ++ awesome ext thank you stackoverflow
    
    // Login button become active once password starting to be entered ****
    
    // textboxt change value of return key to next / Login ++
    
    // failed log in attempt warning ++ / forgot password?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logInView.delegate = self
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let nextField = logInView.emailTextField.superview?.viewWithTag(logInView.emailTextField.tag + 1) as? UITextField {
            
            nextField.becomeFirstResponder()
            
        } else {
            
            logInView.resignFirstResponder()
            
        }
        return false
    }
    
    func pressNewUser() {
      let vc = NewUserViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func pressLogin() {
        
        let email = logInView.emailTextField.text!
        let password = logInView.passwordTextField.text!
        
        
        FirebaseManager.loginUser(withEmail: email, andPassword: password) { (response) in
            switch response {
            case let .successfulLogin(user):
                print(user.uid)
                NotificationCenter.default.post(name: .closeLoginVC, object: nil)

            case let .failure(failString):
                print(failString)
                self.alert(message: failString)
                
            default:
                print("Firebase login failure")
            }
        }
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    
    func alert(message: String, title: String = "") {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    
    }
    
}

