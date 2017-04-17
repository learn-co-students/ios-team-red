
//
//  ViewController.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit

class LogInViewController: UIViewController, LoginViewDelegate, UITextFieldDelegate, GIDSignInUIDelegate, GIDSignInDelegate, FBSDKLoginButtonDelegate {
    
    let logInView = LogInView()
    let healthKitManager = HealthKitManager.sharedInstance
    
    override func loadView() {
        self.view = logInView
        logInView.facebookButton.delegate = self
    
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
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        logInView.delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
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
      
    }
    
    func pressLogin() {
        
      
        let password = logInView.passwordTextField.text!
        if let email = logInView.emailTextField.text {
            
            
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
        } else {
            alert(message: "email required")
        }

    }
 //MARK: Google login
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        guard let authentication = user.authentication else { return }
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        FIRAuth.auth()?.signIn(with: credential) { (firUser, error) in
            guard let firUser = firUser else {return}
            print(firUser.uid)
            FirebaseManager.checkForPrevious(uid: firUser.uid, completion: { (userExists) in
                if userExists {
                    print("logged in previous user")
                    NotificationCenter.default.post(name: .closeLoginVC, object: nil)
                } else {
                    print("logged in new user")
                    let vc = NewUserViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    //self.present(vc, animated: true, completion: nil)
                }
            })
        }
        if let error = error {
            return
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        FirebaseManager.logoutUser { (response) in
            switch response {
            case .successfulLogout(let successString):
                print(successString)
            case .failure(let failString):
                print(failString)
            default:
                print("Invalid firebase response")
            }
        }
    }
    
    //MARK: Facebook login delegate
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential, completion: { (firUser, error) in
            guard let firUser = firUser else {return}
            FirebaseManager.checkForPrevious(uid: firUser.uid, completion: { (userExists) in
                if userExists {
                    print("logged in previous user")
                    NotificationCenter.default.post(name: .closeLoginVC, object: nil)
                } else {
                    print("logged in new user")
                    let vc = NewUserViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                    //self.present(vc, animated: true, completion: nil)
                }
            })
        })
            if let error = error {
                // ...
                return
            }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        FirebaseManager.logoutUser { (response) in
            switch response {
            case .successfulLogout(let successString):
                print(successString)
            case .failure(let failString):
                print(failString)
            default:
                print("Invalid firebase response")
            }
        }
        
    }
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        
        return true
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

