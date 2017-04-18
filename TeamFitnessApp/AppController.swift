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


final class AppController: UIViewController {

    
    var containerView: UIView!
    var actingVC: UIViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            let vc = LoginNavVC()
            self.actingVC = vc
            self.add(viewController: self.actingVC, animated: true)
            return
        }
        
        FirebaseManager.checkForPrevious(uid: uid) { (userExistsInDB) in
            if userExistsInDB {
                let vc = TabBarController()
                self.actingVC = vc
                self.add(viewController: self.actingVC, animated: true)
            } else {
                let vc = LoginNavVC()
                self.actingVC = vc
                self.add(viewController: self.actingVC, animated: true)
            }
            
        }
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

//MARK: Extensions

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
