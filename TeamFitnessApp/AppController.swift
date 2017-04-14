//
//  AppController.swift
//  TeamFitnessApp
//
//  Created by Alessandro Musto on 4/10/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn


final class AppController: UIViewController, GIDSignInDelegate {

    
    var containerView: UIView!
    var actingVC: UIViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        containerView = UIView(frame: view.frame)
        view = containerView
        addNotifcationObservers()
        loadInitialViewController()
    }
    

}

//MARK: - Notification Observers

extension AppController {
    func addNotifcationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(with:)), name: .closeLoginVC, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(switchViewController(with:)), name: .closeDashboardVC, object: nil)
        
    }
}

//MARK: - Loading VC's

extension AppController {
    func loadInitialViewController() {
        
        let vc = FIRAuth.auth()?.currentUser != nil ? TabBarController() : LoginNavVC()
        self.actingVC = vc
        self.add(viewController: self.actingVC, animated: true)
        
    }
}

extension AppController {
    
    func add(viewController: UIViewController, animated: Bool = false) {
        self.addChildViewController(viewController)
        containerView.addSubview(viewController.view)
        containerView.alpha = 0.0
        viewController.view.frame = containerView.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.didMove(toParentViewController: self)
        
        guard animated else { containerView.alpha = 1.0; return }
        
        UIView.transition(with: containerView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.containerView.alpha = 1.0
        }) { _ in }
    }
    
    func switchViewController(with notification: Notification) {
        switch notification.name {
        case Notification.Name.closeLoginVC:
            switchToViewController(with: TabBarController())
        case Notification.Name.closeDashboardVC:
            switchToViewController(with: LoginNavVC())
        default:
            fatalError("\(#function) - Unable to match notficiation name.")
        }
        
    }
    
    private func switchToViewController(with vc: UIViewController) {
        let existingVC = actingVC
        existingVC?.willMove(toParentViewController: nil)
        actingVC = vc
        add(viewController: actingVC)
        actingVC.view.alpha = 0.0
        
        UIView.animate(withDuration: 0.8, animations: {
            self.actingVC.view.alpha = 1.0
            existingVC?.view.alpha = 0.0
        }) {

          success in
            existingVC?.view.removeFromSuperview()
            existingVC?.removeFromParentViewController()
            self.actingVC.didMove(toParentViewController: self)
        }
        
    }

}

extension AppController {
    // MARK: Google sign in delegate functions
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // ...
        guard let authentication = user.authentication else { return }
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        FIRAuth.auth()?.signIn(with: credential) { (FIRUser, error) in
            guard let FIRUser = FIRUser else {return}
            if FirebaseManager.checkForPrevious(uid: FIRUser.uid) {
                print("logged in previous user")
                NotificationCenter.default.post(name: .closeLoginVC, object: nil)
            } else {
                print("logged in new user")
                let googleLoginNav = UINavigationController()
                let vc = NewUserViewController()
                //self.present(vc, animated: true, completion: nil)
                googleLoginNav.pushViewController(vc, animated: true)
            }
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
}

extension Notification.Name {
    static let closeLoginVC = Notification.Name("close-login-view-controller")
    static let closeDashboardVC = Notification.Name("close-dashboard-view-controller")
}

extension UIView {
    
    func constrainEdges(to view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    

    
}
