//
//  DataStore.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/20/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import Firebase

class DataStore {
    
    static let sharedInstance = DataStore()
    var allUsers = [User]()
    var allChallenges = [Challenge]()
    var allTeams = [Team]()
    
    private init() {
        observeAllTeams()
    }
    
    func observeAllTeams() {
        FirebaseManager.fetchAllTeams { (teams) in
            self.allTeams = teams
        }
    }
    
    func observeAllUsers() {
        FirebaseManager.fetchAllUsers() { (users) in
            self.allUsers = users
        }
    }
    
    
    
    
}
