//
//  ViewController.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/3/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        
        var testUser1 = User(name: "Test user 1", sex: "female", height: 75.5, weight: 125, teams: [], challenges: [], imageURL: "www.something.com", uid: "UID1234", email: "test1@test.com")
        var testUser2 = User(name: "test User 2", sex: "male", height: 80.1, weight: 200, teams: [], challenges: [], imageURL: "www.somethingelse.comm", uid: "UID5678", email: "testuser2@test.com")
        var testTeam1 = Team(users: [testUser1, testUser2], captain: testUser1, challenges: [], imageURL: "www.cool.com", id: "team1UID1234")
        var testTeam2 = Team(users: [testUser1, testUser2], captain: testUser2, challenges: [], imageURL: "www.notcool.com", id: "team2UID5678")
        var testChallenge1 = Challenge(startDate: Date(), endDate: Date(), goal: .caloriesBurned(2000), creator: testUser1, users: [testUser1, testUser2], isPublic: true, team: nil, id: "testChallenge2ID1234")
        var testChallenge2 = Challenge(startDate: Date(), endDate: Date(), goal: .caloriesBurned(4000), creator: testUser2, users: [testUser1, testUser2], isPublic: false, team: testTeam1, id: "testChallenge2ID5678")
        
        testUser1.teams = [testTeam1, testTeam2]
        testUser2.teams = [testTeam1, testTeam2]
        testUser1.challenges = [testChallenge1, testChallenge2]
        testUser2.challenges = [testChallenge1, testChallenge2]
        
        testTeam1.challenges = [testChallenge1, testChallenge2]
        testTeam2.challenges = [testChallenge1, testChallenge2]
        
        FirebaseManager.save(user: testUser1)
        FirebaseManager.save(user: testUser2)
        
        FirebaseManager.save(team: testTeam1)
        FirebaseManager.save(team: testTeam2)
        
    }
    
    
}

