
//
//  ViewController.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController, LoginViewDelegate {
    
    let logInView = LogInView()
    
    override func loadView() {
        self.view = logInView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        logInView.delegate = self
    }
    
    func pressNewUser() {
        self.present(NewUserViewController(), animated: true, completion: nil)
    }

}
