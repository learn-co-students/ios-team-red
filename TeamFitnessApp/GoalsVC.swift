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
//    var userPassword: String = ""
    var weight: Int = 0
    var gender: String!
    var height: Float = 0
    var firstGoal = Goal(type: .exerciseMinutes, value: 0)
    var secondGoal = Goal(type: .caloriesBurned, value: 0)
    var uid: String = ""
    
    let goalsView = GoalsView()
    let healthKitManager = HealthKitManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    
    override func loadView() {
        
        goalsView.delegate = self
        self.view = goalsView
        self.hideKeyboardWhenTappedAround()
        
       
//        print("Goals name \(name)")
//        print("Goals email \(userEmail)")
//        print("Goals password \(userPassword)")
//        print("Goals weight \(weight)")
//        print("Goals gender \(gender)")
//        print("Goals height \(height)")
//        print("Goals uid \(uid)")

    
    }
    
    
    
    func pressCreateUserButton() {
        
        guard let activityText = goalsView.activityMinutesADay.text? else {
            goalsView.activityMinutesADay.flashRed()
            return
        }
        guard let tempGoal = Double(activityText) else {
            
        }
        firstGoal.setValue(from: tempGoal)
      
        
        let tempGoal2 = Double(goalsView.caloriesADay.text!)
        secondGoal.setValue(from: tempGoal2!)
      
        print("saving gender \(gender)")
        let user = User(name: name, sex: gender, height: height, weight: weight, teamIDs: [], challengeIDs: [], goals: [firstGoal, secondGoal], email: userEmail, uid: uid)
        
        
        FirebaseManager.save(user: user) { (success) in
            if success {
              self.presentAlert()
            }
        }
        
        
  
        print("Goals name \(name)")
        print("Goals email \(userEmail)")
//        print("Goals password \(userPassword)")
        print("Goals weight \(weight)")
        print("Goals gender \(gender)")
        print("Goals height \(height)")
        print("Goals uid \(uid)")
    }

  func presentAlert() {
    let alertVC = UIAlertController(title: "Apple Health Kit Authorization Request", message: "In order for this app to function properly you must allow access to Apple's Health Kit fitness data", preferredStyle: .alert)
    let allowAction = UIAlertAction(title: "Allow", style: .default) { (action) in
      self.healthKitManager.requestHealthKitAuth { (success) in
        if success {
          DispatchQueue.main.async {
            NotificationCenter.default.post(name: .closeLoginVC, object: nil)
          }
        }
      }

    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
      self.dismiss(animated: true, completion: nil)
    }

    alertVC.addAction(allowAction)
    alertVC.addAction(cancelAction)

    self.present(alertVC, animated: true, completion: nil)
  }


}
