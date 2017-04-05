//
//  Team.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/4/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation


struct Team {
    
    var users: [User]
    var captain: User
    var challenges: [Challenge]
    var imageURL: String
    var id: String? = nil
    
    init(dict: [String: Any]) {
        self.users = dict["users"] as! [User]
        self.captain = dict["captain"] as! User
        self.challenges = dict["challenges"] as! [Challenge]
        self.imageURL = dict["teamImage"] as? String ?? ""
    }
    
    init(users: [User], captain: User, challenges: [Challenge], imageURL: String, id: String) {
        self.users = users
        self.captain = captain
        self.challenges = challenges
        self.imageURL = imageURL
        self.id = id
    }

}


