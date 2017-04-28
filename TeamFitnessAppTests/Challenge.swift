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
    var userUIDs = [String:Double]()
    var isPublic: Bool
    var teamID: String?
    var id: String?
    var name: String

    init(id: String, dict: [String: Any]) {
        self.name = dict["name"] as? String ?? "No Name"
        self.creator = dict["creator"] as? String ?? nil
        self.isPublic = dict["isPublic"] as? Bool ?? false
        self.teamID = dict["team"] as? String ?? nil
        self.id = id

        let goalDict = dict["goal"] as? [String: Double] ?? [:]
        for (key, value) in goalDict {
            if let goalType = GoalType(rawValue: key) {
                let goal = Goal(type: goalType, value: value)
                self.goal = goal
            }
        }

        self.startDate = Date(timeIntervalSince1970: dict["startDate"] as? TimeInterval ?? 0)
        self.endDate = Date(timeIntervalSince1970: dict["endDate"] as? TimeInterval ?? 0)
        let userDict = dict["users"] as? [String: Double] ?? [:]
        for (userID, value) in userDict {
            self.userUIDs[userID] = value
        }
    }

    init(name: String = "", startDate: Date, endDate: Date, goal: Goal, creatorID: String, userUIDs: [String:Double], isPublic: Bool, team: String?, id: String? = nil) {
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

