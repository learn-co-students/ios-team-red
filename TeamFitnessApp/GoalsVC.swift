//
//  GoalsViewController.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/10/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import UIKit


class GoalsViewController: UIViewController {
    
    
    var name: String!
    var userEmail: String!
    var userPassword: String!
    var weight: Int!
    var gender: String!
    var height: Int!
    
    
    
    
    let goalsView = GoalsView()
    
    override func loadView() {
        self.view = goalsView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(name)
        print(userEmail)
        print(userPassword)
        print(weight)
        print(gender)
        print(height)
    }
    
}
