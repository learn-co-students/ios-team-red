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
    
    let goalsView = GoalsView()
    
    override func loadView() {
        self.view = goalsView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
