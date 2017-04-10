
//
//  ViewController.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    let logInView = LogInView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         self.logInView.newUserButton.addTarget(self, action: #selector(pressNewUserButton), for: UIControlEvents.touchUpInside)
    }
    
    override func loadView() {
        self.view = logInView
    }
    
    func pressNewUserButton() {
        self.present(NewUserViewController(), animated: true, completion: nil)
    }
}
