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
    var imageURL: String
    var uid: String
    var email: String?
    
    init(uid: String, dict: [String: Any]) {
        self.uid = uid
        self.name = dict["name"] as? String ?? ""
        self.sex = dict["Sex"] as? String ?? ""
        self.height = dict["height"] as? Float ?? 0.0
        self.weight = dict["weight"] as? Int ?? 0
        self.imageURL = dict["imageURL"] as? String ?? ""
        
        let challengeDict = dict["challenges"] as? [String: Bool] ?? [:]
        for (challengeID, _) in challengeDict {
            self.challengeIDs.append(challengeID)
        }
        
        let teamDict = dict["teams"] as? [String: Bool] ?? [:]
        for (teamID, _) in teamDict {
            self.teamIDs.append(teamID)
        }
    }
    
    init(name: String, sex: String, height: Float, weight: Int, teamIDs: [String], challengeIDs: [String], imageURL: String, uid: String, email: String) {
        self.name = name
        self.sex = sex
        self.height = height
        self.weight = weight
        self.teamIDs = teamIDs
        self.challengeIDs = challengeIDs
        self.imageURL = imageURL
        self.uid = uid
        self.email = email
    }
}