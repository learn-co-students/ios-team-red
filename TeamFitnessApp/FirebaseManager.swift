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
}






















