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
    
    
    var name: String!
    var userEmail: String!
    var userPassword: String!
    var weight: Int!
    var gender: String!
    var height: Float!
    var firstGoal = Goal(type: .exerciseTime, value: 0)
    var secondGoal = Goal(type: .caloriesBurned, value: 0)
    
    
    
    let goalsView = GoalsView()
    
    override func loadView() {
        
        goalsView.delegate = self
        self.view = goalsView
        self.hideKeyboardWhenTappedAround()

    }
    
    func pressCreateUserButton() {
        
        let tempGoal = Double(goalsView.activityMinutesADay.text!)
        firstGoal.setValue(from: tempGoal!)
        
        let tempGoal2 = Double(goalsView.caloriesADay.text!)
        secondGoal.setValue(from: tempGoal2!)
        
        let user = User(name: name!, sex: gender!, height: height!, weight: weight!, teamIDs: [], challengeIDs: [], goals: [firstGoal, secondGoal], email: userEmail!, uid: nil)
        
        FirebaseManager.createNew(User: user, withPassword: userPassword!) { (response) in
            switch response {
            case let .successfulNewUser(user):
//                print (user.uid)
                NotificationCenter.default.post(name: .closeLoginVC, object: nil)
            case let .failure(error):
                print(error)
            default:
                print("default")
                
            
            }
        }
        
//        FirebaseManager.loginUser(withEmail: email, andPassword: password) { (response) in
//            switch response {
//            case let .successfulLogin(user):
//                print(user.uid)
//                self.present(DashboardVC(), animated: true, completion: nil)
//            case let .failure(failString):
//                print(failString)
//                self.alert(message: "Log In Failed")
//                
//            default:
//                print("Firebase login failure")
//            }
//
//        
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Goals name \(name)")
        print("Goals email \(userEmail)")
        print("Goals password \(userPassword)")
        print("Goals weight \(weight)")
        print("Goals gender \(gender)")
        print("Goals height \(height)")
    }
    
}
