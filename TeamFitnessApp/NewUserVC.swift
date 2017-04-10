//
//  CreateNewUserViewController.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController, NewUserViewDelegate {
    
    var createNewUserView = NewUserView()

    override func loadView() {
        
        self.view = createNewUserView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        createNewUserView.delegate = self
    }

    
    func pressProfileButton() {
        
        self.present(ProfileViewController(), animated: true, completion: nil)
    }
    
}


