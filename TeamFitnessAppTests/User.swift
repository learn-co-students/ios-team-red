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
    var userImage: String
    
    init(dict: [String: Any]) {
        self.name = dict["name"] as! String
        self.sex = dict["Sex"] as! String
        self.height = dict["height"] as! Float
        self.weight = dict["weight"] as! Int
        self.teams = dict["teams"] as! [Team]
        self.challenges = dict["challenges"] as! [Challenge]
        self.userImage = dict["userImage"] as! String
    }
}
