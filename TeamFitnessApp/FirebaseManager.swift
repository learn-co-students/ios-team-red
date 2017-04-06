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
    
// Login funcions ******************************************************************************************************************************
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

//save functions ************************************************************************************************************************************
    static func save(user: User) {// saves a user to the Firebase database
        let key = dataRef.child("users").child(user.uid)
        var challengesDict = [String: Bool]()
        var teamsDict = [String: Bool]()
        
        for challenge in user.challengeIDs {
            challengesDict[challenge] = true
        }
        
        for team in user.teamIDs {
            teamsDict[team] = true
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
    
    static func save(team: Team) {// saves a team to Firebase database
        let key = dataRef.child("teams").child(team.id)
        var usersDict = [String: Bool]()
        var challengesDict = [String: Bool]()
        
        for user in team.userUIDs {
            usersDict[user] = true
        }
        
        for challenge in team.challengeIDs {
            challengesDict[challenge] = true
        }
        
        let post: [String: Any] = [
            "captain": team.captain,
            "users": usersDict,
            "challenges": challengesDict,
            "imageURL": team.imageURL
        ]
        
        key.updateChildValues(post)
    }
    
    static func save(challenge: Challenge) {// saves a challenge to Firebase database
        guard let challengeID = challenge.id else {return}
        let key = dataRef.child("challenges").child(challengeID)
        var usersDict = [String: Bool]()
        
        for user in challenge.userUIDs {
            usersDict[user] = true
        }
        
        let teamID = challenge.teamID ?? "no team"
        let post: [String: Any] = [
            "users": usersDict,
            "creator": challenge.creator ?? "No Creator",
            "isPublic": challenge.isPublic ?? false,
//            "startDate": String(challenge.startDate), TODO add function to the Challenge class that changes dates to string and vice versa
//            "endDate": String(challenge.endDate),
            "team": teamID
        ]
        
        key.updateChildValues(post)
    }
//fetch functions ************************************************************************************************************************************
    
    //fetches a user from Firebase given a user id string, and returns the user through a closure
    static func fetchUser(withUID uid: String, completion: @escaping (User) -> Void) {//TODO implement some better error handling
        dataRef.child("users").child(uid).observe(.value, with: { (snapshot) in
            if let userDict = snapshot.value as? [String: Any] {
                let user = User(uid: uid, dict: userDict)
                completion(user)
            }
        })
    }
    
    //fetches a team from Firebase given a team id string, and returns the team through a closure
    static func fetchTeam(withTeamID teamID: String, completion: @escaping (Team) -> Void) {
        dataRef.child("teams").child(teamID).observe(.value, with: { (snapshot) in
            if let teamDict = snapshot.value as? [String: Any] {
                let team = Team(id: teamID, dict: teamDict)
                completion(team)
            } else {
                print("Could not fetch team")
            }
        })
    }
    
    //fetches a challenge from Firebase given a challenge id string, and returns the challenge through a closure
    static func fetchChallenge(withChallengeID challengeID: String, completion: @escaping (Challenge) -> Void) {
        dataRef.child("challenges").child(challengeID).observe(.value, with: { (snapshot) in
            if let challengeDict = snapshot.value as? [String: Any] {
                let challenge = Challenge(id: challengeID, dict: challengeDict)
                completion(challenge)
            }
        })
    }
    

    static func fetchAllTeams(completion: @escaping ([Team]) -> Void) { //fetches all teams and returns them in an array through a completion
        var teams = [Team]()
        dataRef.child("teams").observe(.value, with: { (snapshot) in
            let teamDict = snapshot.value as? [String: Any]
            if let teamDict = teamDict {
                for team in teamDict {
                    let teamValues = team.value as? [String: Any] ?? [:]
                    let team = Team(id: team.key, dict: teamValues)
                    teams.append(team)
                }
            }
            completion(teams)
        })
    }
    
    static func fetchAllChallenges(completion: @escaping ([Challenge]) -> Void) { //fetches all challenges and returns them in an array through a completion
        var challenges = [Challenge]()
        dataRef.child("challenges").observe(.value, with: { (snapshot) in
            let challengesDict = snapshot.value as? [String: Any]
            if let challengesDict = challengesDict {
                for challenge in challengesDict {
                    let challengeValues = challenge.value as? [String: Any] ?? [:]
                    let challenge = Challenge(id: challenge.key, dict: challengeValues)
                    challenges.append(challenge)
                }
            }
            completion(challenges)
        })
    }

// addNew functions ******************************************************************************************************************************************
    static func addNew(user: FIRUser) { //adds a new user's UID and email to the Firebase database
        FirebaseManager.dataRef.child("users").child(user.uid).child("email").setValue(user.email)
    }
    
    //adds an instance of Team to Firebase, and returns the auto generated teamID through a closure
    static func addNew(team: Team, completion: (String) -> Void) {
        let teamRef = dataRef.child("teams").childByAutoId()
        let teamID = teamRef.key
        
        var usersDict = [String: Bool]()
        var challengesDict = [String: Bool]()
        
        for user in team.userUIDs {
            usersDict[user] = true
        }
        
        for challenge in team.challengeIDs {
            challengesDict[challenge] = true
        }
        
        let post: [String: Any] = [
            "captain": team.captain,
            "users": usersDict,
            "challenges": challengesDict,
            "imageURL": team.imageURL
        ]
        teamRef.updateChildValues(post)
        completion(teamID)
    }
    
    static func addNew(challenge: Challenge, completion: (String) -> Void) {
        let challengeRef = dataRef.child("challenges").childByAutoId()
        let challengeID = challengeRef.key
        
        var usersDict = [String: Bool]()
        
        for user in challenge.userUIDs {
            usersDict[user] = true
        }
        
        let teamID = challenge.teamID ?? "no team"
        let post: [String: Any] = [
            "users": usersDict,
            "creator": challenge.creator ?? "No Creator",
            "isPublic": challenge.isPublic ?? false,
            //            "startDate": String(challenge.startDate), TODO add function to the Challenge class that changes dates to string and vice versa
            //            "endDate": String(challenge.endDate),
            "team": teamID
        ]
        
        challengeRef.updateChildValues(post)
        completion(challengeID)
    }
    
    
// test data ******************************************************************************************************************************************
    
    
    static func generateTestData() {
        let testUser3 = User(name: "test user 3", sex: "male", height: 120.2, weight: 300, teamIDs: [], challengeIDs: [], imageURL: "a cool imageurl", uid: "testUser3UID91011", email: "testuser3@testorama.com")
        let testChallenge3 = Challenge(startDate: Date(), endDate: Date(), goal: .caloriesBurned(200), creator: testUser3, userUIDs: [], isPublic: true, team: "awesome test team", id: nil)
        
        FirebaseManager.addNew(challenge: testChallenge3) { (id) in
            print("Challenge added to database \(id)")
        }
    }
}






















