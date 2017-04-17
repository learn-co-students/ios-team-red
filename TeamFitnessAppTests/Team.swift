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
    var captainID: String
    var challengeIDs = [String]()
    var imageURL: String
    var id: String?
    var name: String
    var oldChallengeIDs = [String]()
    
    init(id: String, dict: [String: Any]) {
        self.captainID = dict["captain"] as? String ?? ""
        self.imageURL = dict["teamImage"] as? String ?? ""
        self.name = dict["name"] as? String ?? ""
        self.id = id
        
        let userDict = dict["users"] as? [String: Bool] ?? [:]
        for (userID, _) in userDict {
            self.userUIDs.append(userID)
        }
        
        let challengeDict = dict["challenges"] as? [String: Bool] ?? [:]
        for (challengeID, _) in challengeDict {
            self.challengeIDs.append(challengeID)
        }

      let oldChallengeDict = dict["oldChallenges"] as? [String: Bool] ?? [:]
      for (challengeID, _) in oldChallengeDict {
        self.oldChallengeIDs.append(challengeID)
      }
    }

    init(userUIDs: [String], captainID: String, challengeIDs: [String], imageURL: String, id: String? = nil, name: String) {
        self.userUIDs = userUIDs
        self.captainID = captainID
        self.challengeIDs = challengeIDs
        self.imageURL = imageURL
        self.id = id
        self.name = name
    }

}


