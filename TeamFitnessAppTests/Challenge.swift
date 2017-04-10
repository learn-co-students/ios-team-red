//
//  Challenge.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/4/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation


struct Challenge {
    
    var startDate: Date //TODO come up with functions to convert dates to strings!
    var endDate: Date
    var goal: [String:Double]
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
      self.goal = dict["goal"] as? [String: Double] ?? [:]
        self.endDate = Date()
        self.startDate = Date()
        
        let userDict = dict["users"] as? [String: Bool] ?? [:]
        for (userID, _) in userDict {
            self.userUIDs.append(userID)
        }
    }
    
    init(startDate: Date, endDate: Date, goal: Goal, creator: User, userUIDs: [String], isPublic: Bool, team: String?, id: String? = nil, name: String = "") {
        self.startDate = startDate
        self.endDate = endDate
        self.goal = [goal.type.rawValue: goal.value]
        self.creator = creator.uid
        self.userUIDs = userUIDs
        self.isPublic = isPublic
        self.teamID = team
        self.id = id
        self.name = name
    }
    
}
