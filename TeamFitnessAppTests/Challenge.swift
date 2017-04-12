//
//  Challenge.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/4/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation


struct Challenge {
    
    var startDate: Date?
    var endDate: Date?
    var goal: Goal?
    var creator: String?
    var userUIDs = [String]()
    var isPublic: Bool?
    var teamID: String?
    var id: String?
    var name: String
    
    init(id: String, dict: [String: Any]) {
        self.name = dict["name"] as? String ?? "No Name"
        self.creator = dict["creator"] as? String ?? nil
        self.isPublic = dict["isPublic"] as? Bool ?? nil
        self.teamID = dict["team"] as? String ?? nil
        self.id = id
        
        let goalDict = dict["goal"] as? [String: Double] ?? [:] 
        for (key, value) in goalDict {
          if let goalType = GoalType(rawValue: key) {
            let goal = Goal(type: goalType, value: value)
            self.goal = goal
          }
        }


        self.startDate = (dict["startDate"] as? String)?.convertToDate()
        self.endDate = (dict["endDate"] as? String)?.convertToDate()
        let userDict = dict["users"] as? [String: Bool] ?? [:]
        for (userID, _) in userDict {
            self.userUIDs.append(userID)
        }
    }
    
    init(name: String = "", startDate: Date, endDate: Date, goal: Goal, creatorID: String, userUIDs: [String], isPublic: Bool, team: String?, id: String? = nil) {
        self.startDate = startDate
        self.endDate = endDate
        self.goal = goal
        self.creator = creatorID
        self.userUIDs = userUIDs
        self.isPublic = isPublic
        self.teamID = team
        self.id = id
        self.name = name
    }
}

