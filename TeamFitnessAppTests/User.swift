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
    var teams: [Team]
    var challenges: [Challenge]
    var imageURL: String
    var uid: String
    var email: String?
    
    init(uid: String, dict: [String: Any]) {
        self.uid = uid
        self.name = dict["name"] as? String ?? ""
        self.sex = dict["Sex"] as? String ?? ""
        self.height = dict["height"] as? Float ?? 0.0
        self.weight = dict["weight"] as! Int
        self.teams = dict["teams"] as! [Team]
        self.challenges = dict["challenges"] as! [Challenge]
        self.imageURL = dict["userImage"] as! String
    }
    
    init(name: String, sex: String, height: Float, weight: Int, teams: [Team], challenges: [Challenge], imageURL: String, uid: String, email: String) {
        self.name = name
        self.sex = sex
        self.height = height
        self.weight = weight
        self.teams = teams
        self.challenges = challenges
        self.imageURL = imageURL
        self.uid = uid
        self.email = email
    }
}
