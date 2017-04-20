
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
        logInView.passwordTextField.returnKeyType = .go
        
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    
    // textbox return changes field form email to password  ++
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

      if textField == logInView.passwordTextField {
        pressLogin()

      }
        return false
    }
    
    //    func textFieldShouldClear(_ textField: UITextField) -> Bool {
    //        textField.resignFirstResponder()
    //        return true
    //    }
    
    func pressNewUser() {
        FirebaseManager.logoutUser { (response) in
            switch response {
            case .successfulLogout(let logString):
                print(logString)
                let vc = NewUserViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            case .failure(let failString):
                print(failString)
            default:
                print("Invalid Firebase response during attempt to logout user")
            }
        }
    }
    
    func pressLogin() {
    
        let password = logInView.passwordTextField.text!
        if let email = logInView.emailTextField.text {
            
            FirebaseManager.loginUser(withEmail: email, andPassword: password) { (response) in
                switch response {
                case let .successfulLogin(user):
                    print(user.uid)
                    //print("SHOULD GO TO DASHBOARD OR TO CREATE NEW USER VIEW IF USER DOES NOT HAVE A PROFILE***********")
                    FirebaseManager.checkForPrevious(uid: user.uid, completion: { (userExistsInDB) in
                        if userExistsInDB {
                            NotificationCenter.default.post(name: .closeLoginVC, object: nil)
                        } else {
                            let vc = NewUserViewController()
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    })
                    
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

    func pressForgot() {
        let vc = ForgotPasswordVC()
        let navVC = NavigationController(rootViewController: vc)
        vc.modalPresentationStyle = .overFullScreen
        self.present(navVC, animated: true, completion: nil)

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
        
        guard !result.isCancelled else { return }
        print(error.localizedDescription)
        
        let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        FIRAuth.auth()?.signIn(with: credential, completion: { (firUser, error) in
            guard let firUser = firUser else {return}// TODO: handle failed facebook login
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
            print(error.localizedDescription)
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



