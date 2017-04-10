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
    
//MARK: - login functions
    //create a new firebase user with a given email in Firebase, and add that User to the Firebase database. Returns the User through a closure
    static func createNew(User user: User, withPassword password: String, completion: @escaping (FirebaseResponse) -> Void) {
        guard let userEmail = user.email else {
            print("Could not create new user in database - user has no email")
            return
        }
        FIRAuth.auth()?.createUser(withEmail: userEmail, password: password, completion: { (firUser, error) in
            if let firUser = firUser {
                var updatedUser  = user
                updatedUser.uid = firUser.uid
                FirebaseManager.save(user: updatedUser)
                completion(.successfulNewUser(updatedUser))
            } else {
                completion(.failure("FirebaseManager could not create new user"))
            }
        })
    }
    
    //login a user with a given email. Returns a FirebaseResponse upon completion
    static func loginUser(withEmail email: String, andPassword password: String, completion: @escaping (FirebaseResponse) -> Void) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if let user = user {
                completion(.successfulLogin(user))
            } else {
                completion(.failure("FirebaseManager could not log in user"))
            }
        })
    }
    
    
    //log out the current Firebase user. Returns a FirebaseResponse upon completion
    static func logoutUser(completion: (FirebaseResponse) -> Void) {
        do {
            try FIRAuth.auth()?.signOut()
            completion(.successfulLogout("User logged out"))
        } catch {
            completion(.failure("FirebaseManager could not log out user"))
        }
    }

//MARK: - save functions
    static func save(user: User) {// saves a user to the Firebase database
        guard let userUID = user.uid else {
            print("Attempt to save user to database failed. User has no UID")
            return
        }
        let key = dataRef.child("users").child(userUID)
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
        ]
        
        key.updateChildValues(post)
    }
    
    static func save(team: Team) {// saves a team to Firebase database
        guard let teamID = team.id else {return} //TODO: - handle this error better
        let key = dataRef.child("teams").child(teamID)
        var usersDict = [String: Bool]()
        var challengesDict = [String: Bool]()
        
        for user in team.userUIDs {
            usersDict[user] = true
        }
        
        for challenge in team.challengeIDs {
            challengesDict[challenge] = true
        }
        
        let post: [String: Any] = [
            "captain": team.captainID,
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
//MARK: - Fetch functions
    
    //fetches a user from Firebase given a user id string, and returns the user through a closure
    static func fetchUser(withFirebaseUID uid: String, completion: @escaping (User) -> Void) {//TODO implement some better error handling
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
    private static func addNew(user: FIRUser) { //adds a new user's UID and email to the Firebase database
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
            "name": team.name,
            "captain": team.captainID,
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
    
    
// MARK: - Test functions
    static func generateTestData() {
        print("generating test data")
        let newUser = User(name: "Pat is cool", sex: "Batman", height: 5000, weight: 10, email: "batman@batman.com")
        FirebaseManager.createNew(User: newUser, withPassword: "1234batman") { (response) in
            switch response {
            case let .successfulNewUser(user):
                print("NEW USER CREATED WITH UID: \(user.uid!)")
            default:
                print("new user not created :(")
            }
        }
    }
}






















