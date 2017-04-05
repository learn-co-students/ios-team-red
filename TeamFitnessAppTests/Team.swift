//
//  Team.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/4/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation


struct Team {
    
    var userUIDs = [String]()
    var captain: String
    var challengeIDs = [String]()
    var imageURL: String
    var id: String
    
    init(id: String, dict: [String: Any]) {
        self.captain = dict["captain"] as? String ?? ""
        self.imageURL = dict["teamImage"] as? String ?? ""
        self.id = id
        
        let userDict = dict["users"] as? [String: Bool] ?? [:]
        for (userID, _) in userDict {
            self.userUIDs.append(userID)
        }
        
        let challengeDict = dict["challenges"] as? [String: Bool] ?? [:]
        for (challengeID, _) in challengeDict {
            self.challengeIDs.append(challengeID)
        }
    }
    
    init(userUIDs: [String], captain: User, challengeIDs: [String], imageURL: String, id: String) {
        self.userUIDs = userUIDs
        self.captain = captain.uid
        self.challengeIDs = challengeIDs
        self.imageURL = imageURL
        self.id = id
    }

}


