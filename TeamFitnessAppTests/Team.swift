//
//  Team.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/4/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation


struct Team {
    
    var userUIDs: [String]
    var captain: User
    var challengeIDs: [String]
    var imageURL: String
    var id: String
    
    init(id: String, dict: [String: Any]) {
        self.userUIDs = dict["users"] as! [String]
        self.captain = dict["captain"] as! User
        self.challengeIDs = dict["challenges"] as! [String]
        self.imageURL = dict["teamImage"] as? String ?? ""
        self.id = id
    }
    
    init(userUIDs: [String], captain: User, challengeIDs: [String], imageURL: String, id: String) {
        self.userUIDs = userUIDs
        self.captain = captain
        self.challengeIDs = challengeIDs
        self.imageURL = imageURL
        self.id = id
    }

}


