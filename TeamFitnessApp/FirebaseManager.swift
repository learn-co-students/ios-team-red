//
//  FirebaseManager.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/4/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import Firebase

struct FirebaseManager {
    
    static var dataRef: FIRDatabaseReference = FIRDatabase.database().reference()
    
    //create a new user with a given email in Firebase, and add that user's UID and email to the database
    static func createNewUser(withEmail email: String, andPassword password: String, completion: @escaping (FirebaseResponse) -> Void) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if let user = user {
                addNew(user: user)
                completion(.successfulNewUser(user))
            } else {
                completion(.failedNewUser("FirebaseManager could not create new user"))
            }
        })
    }
    
    //login a user with a given email. Returns a FirebaseResponse upon completion
    static func loginUser(withEmail email: String, andPassword password: String, completion: @escaping (FirebaseResponse) -> Void) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if let user = user {
                completion(.successfulLogin(user))
            } else {
                completion(.failedNewUser("FirebaseManager could not log in user"))
            }
        })
    }
    //log out the current Firebase user. Returns a FirebaseResponse upon completion
    static func logoutUser(completion: (FirebaseResponse) -> Void) {
        do {
            try FIRAuth.auth()?.signOut()
            completion(.successfulLogout("User logged out"))
        } catch {
            completion(.failedLogout("FirebaseManager could not log out user"))
        }
    }
    
    static func addNew(user: FIRUser) { //adds a new user's UID and email to the Firebase database
        FirebaseManager.dataRef.child("users").child(user.uid).child("email").setValue(user.email)
    }
    
    static func save(user: User) {// saves a user to the Firebase database
        let key = dataRef.child("users").child(user.uid)
        var challengesDict = [String: Bool]()
        var teamsDict = [String: Bool]()
        
        for challenge in user.challenges {
            challengesDict[challenge.id] = true
        }
        
        for team in user.teams {
            teamsDict[team.id] = true
        }
        
        let post: [String: Any] = [
            "name": user.name,
            "email": user.email ?? "",
            "gender": user.sex,
            "height": user.height,
            "weight": user.weight,
            "teams": teamsDict,
            "challenges": challengesDict,
            "imageURL": user.imageURL
        ]
        
        key.updateChildValues(post)
    }
    
    static func save(team: Team) {
        let key = dataRef.child("teams").child(team.id)
        var usersDict = [String: Bool]()
        var challengesDict = [String: Bool]()
        
        for user in team.users {
            usersDict[user.uid] = true
        }
        
        for challenge in team.challenges {
            challengesDict[challenge.id] = true
        }
        
        let post: [String: Any] = [
            "captain": [team.captain.uid: true],
            "users": usersDict,
            "challenges": challengesDict,
            "imageURL": team.imageURL
        ]
        
        key.updateChildValues(post)
    }
    
    static func save(challenge: Challenge) {
        let key = dataRef.child("challenges").child(challenge.id)
        var usersDict = [String: Bool]()
        
        for user in challenge.users {
            usersDict[user.uid] = true
        }
        
        let teamID = challenge.team?.id as? String ?? "no team"
        let post: [String: Any] = [
            "users": usersDict,
            "creator": challenge.creator.uid,
            "isPublic": challenge.isPublic,
//            "startDate": String(challenge.startDate), TODO add function to the Challenge class that changes dates to string and vice versa
//            "endDate": String(challenge.endDate),
            "team": [teamID: true]
        ]
        
        key.updateChildValues(post)
    }
    
    func generateTestData() {
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
        
        FirebaseManager.save(challenge: testChallenge1)
        FirebaseManager.save(challenge: testChallenge2)
    }
}






















