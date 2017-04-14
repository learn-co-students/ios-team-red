//
//  GoalsViewController.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/10/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import UIKit


class GoalsViewController: UIViewController, GoalsViewDelegate {
    
    
    var name: String = ""
    var userEmail: String = ""
    var userPassword: String = ""
    var weight: Int = 0
    var gender: String = ""
    var height: Float = 0
    var firstGoal = Goal(type: .exerciseTime, value: 0)
    var secondGoal = Goal(type: .caloriesBurned, value: 0)
    var uid: String = ""
    
    let goalsView = GoalsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    override func loadView() {
        
        goalsView.delegate = self
        self.view = goalsView
        self.hideKeyboardWhenTappedAround()
        
//        
//        print("Goals name \(name)")
//        print("Goals email \(userEmail)")
//        print("Goals password \(userPassword)")
//        print("Goals weight \(weight)")
//        print("Goals gender \(gender)")
//        print("Goals height \(height)")
//        print("Goals uid \(uid)")

    
    }
    
    
    
    func pressCreateUserButton() {
        
        let tempGoal = Double(goalsView.activityMinutesADay.text!)
        firstGoal.setValue(from: tempGoal!)
      
        
        let tempGoal2 = Double(goalsView.caloriesADay.text!)
        secondGoal.setValue(from: tempGoal2!)
      
        
        let user = User(name: name, sex: gender, height: height, weight: weight, teamIDs: [], challengeIDs: [], goals: [firstGoal, secondGoal], email: userEmail, uid: uid)
        
        
        FirebaseManager.save(user: user) { (success) in
            if success {
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: .closeLoginVC, object: nil)
                }
            }
        }
        
        
  
        print("Goals name \(name)")
        print("Goals email \(userEmail)")
        print("Goals password \(userPassword)")
        print("Goals weight \(weight)")
        print("Goals gender \(gender)")
        print("Goals height \(height)")
        print("Goals uid \(uid)")
    }
    
    
}
