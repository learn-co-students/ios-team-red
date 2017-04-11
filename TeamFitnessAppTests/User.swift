//
//  User.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/4/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation


struct User {
    
    var name: String
    var sex: String
    var height: Float
    var weight: Int
    var teamIDs = [String]()
    var challengeIDs = [String]()
    var goals = [Goal]()
    var uid: String? = nil
    var email: String? = nil
    
    init(uid: String, dict: [String: Any]) {
        self.uid = uid
        self.name = dict["name"] as? String ?? ""
        self.sex = dict["Sex"] as? String ?? ""
        self.height = dict["height"] as? Float ?? 0.0
        self.weight = dict["weight"] as? Int ?? 0
        
        let challengeDict = dict["challenges"] as? [String: Bool] ?? [:]
        for (challengeID, _) in challengeDict {
            self.challengeIDs.append(challengeID)
        }

      let goalArray = dict["goals"] as? [[String:Double]] ?? [[:]]
      for goal in goalArray {
        for (key, value) in goal {
          if let goalType = GoalType(rawValue: key) {
            let goal = Goal(type: goalType, value: value)
            goals.append(goal)
          }
        }
      }
        let teamDict = dict["teams"] as? [String: Bool] ?? [:]
        for (teamID, _) in teamDict {
            self.teamIDs.append(teamID)
        }
    }
    
    init(name: String, email: String, sex: String, height: Float, weight: Int, teamIDs: [String], challengeIDs: [String], imageURL: String, goals: [Goal] = []) {

        self.name = name
        self.sex = sex
        self.height = height
        self.weight = weight
        self.teamIDs = teamIDs
        self.challengeIDs = challengeIDs
        self.email = email
        self.goals = goals
    }
    
    mutating func set(UID uid: String) {
        self.uid = uid
    }
}
