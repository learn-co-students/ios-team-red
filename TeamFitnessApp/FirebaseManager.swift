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



    //MARK: - login functions
    //create a new firebase user with a given email in Firebase, and add that User to the Firebase database. Returns the User through a closure
    static func createNew(withEmail email: String, withPassword password: String, completion: @escaping (FirebaseResponse) -> Void) {

        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (firUser, error) in
            if let firUser = firUser {
                completion(.successfulNewUser(firUser.uid))
            } else {
                completion(.failure(error!.localizedDescription))
            }
        })
    }

    //login a user with a given email. Returns a FirebaseResponse upon completion
    static func loginUser(withEmail email: String, andPassword password: String, completion: @escaping (FirebaseResponse) -> Void) {
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if let user = user {
                completion(.successfulLogin(user))
            } else {
                let error1 = error!
                completion(.failure(error1.localizedDescription))
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


    static func save(user: User, completion: @escaping (Bool) -> ()) {// saves a user to the Firebase database
        let key = dataRef.child("users").child(user.uid!)
        var goalDict = [String: Double]()
        var challengesDict = [String: Bool]()
        var teamsDict = [String: Bool]()

        for challenge in user.challengeIDs {
            challengesDict[challenge] = true
        }

        for goal in user.goals {
            goalDict[goal.type.rawValue] = goal.value
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
            "goals": goalDict,
            "challenges": challengesDict,
            ]


        key.updateChildValues(post)
        completion(true)
    }

    static func save(team: Team) {// saves a team to Firebase database
        guard let teamID = team.id else {return} //TODO: - handle this error better

        let key = dataRef.child("teams").child(teamID)
        let post = FirebaseManager.makeDictionary(fromTeam: team)
        key.updateChildValues(post)
    }

    static func save(challenge: Challenge) {// saves a challenge to Firebase database
        guard let challengeID = challenge.id else {return}
        let key = dataRef.child("challenges").child(challengeID)
        let post = FirebaseManager.makeDictionary(fromChallenge: challenge)
        key.updateChildValues(post)
    }

    static func updateChallengeData(challengeID: String, userID: String, withData data: Double, completion: @escaping () -> ()) {
        let key = dataRef.child("challenges").child(challengeID).child("users")
        key.updateChildValues([userID:data])
        completion()
    }
    // MARK: - Fetch functions

    //fetches a user from Firebase given a user id string, and returns the user through a closure
    static func fetchUser(withFirebaseUID uid: String, completion: @escaping (User) -> Void) {//TODO implement some better error handling
        dataRef.child("users").child(uid).observe(.value, with: { (snapshot) in
            if let userDict = snapshot.value as? [String: Any] {
                let user = User(uid: uid, dict: userDict)
                completion(user)
            }
        })
    }

    //fetch user trophies
    static func fetchUserTrophies(withFirebaseUID uid: String, completion: @escaping ([String:Int]) -> ()) {
        dataRef.child("users").child(uid).child("trophies").observeSingleEvent(of: .value, with: { (snapshot) in
            if let trophyDict = snapshot.value as? [String:Int] {
                completion(trophyDict)
            }
        })
    }

    static func fetchUserOnce(withFirebaseUID uid: String, completion: @escaping (User) -> Void) {
        dataRef.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
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

    static func fetchTeamOnce(withTeamID teamID: String, completion: @escaping (Team) -> Void) {
        dataRef.child("teams").child(teamID).observeSingleEvent(of: .value, with: { (snapshot) in
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
        dataRef.child("challenges").child(challengeID).observe(.value, with: {(snapshot) in
            if let challengeDict = snapshot.value as? [String: Any] {
                let challenge = Challenge(id: challengeID, dict: challengeDict)
                completion(challenge)
            } else {
                print("not in completion")
            }
        })
    }

    static func fetchChallengeOnce(withChallengeID challengeID: String, completion: @escaping (Challenge) -> Void) {
        dataRef.child("challenges").child(challengeID).observeSingleEvent(of: .value, with: { (snapshot) in
            if let challengeDict = snapshot.value as? [String: Any] {
                let challenge = Challenge(id: challengeID, dict: challengeDict)
                completion(challenge)
            } else {
                print("not in completion")
            }
        })
    }

    static func fetchOldChallenge(withChallengeID challengeID: String, completion: @escaping (Challenge) -> Void) {
        dataRef.child("oldChallenges").child(challengeID).observe(.value, with: {(snapshot) in
            if let challengeDict = snapshot.value as? [String: Any] {
                let challenge = Challenge(id: challengeID, dict: challengeDict)
                completion(challenge)
            } else {
                print("not in completion")
            }
        })
    }




    static func fetchAllTeams(completion: @escaping ([Team]) -> Void) { //fetches all teams and returns them in an array through a completion
        dataRef.child("teams").observe(.value, with: { (snapshot) in
            var teams = [Team]()
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

    static func fetchAllTeamsOnce(completion: @escaping ([Team]) -> Void) { //fetches all teams and returns them in an array through a completion
        dataRef.child("teams").observeSingleEvent(of: .value, with: { (snapshot) in
            var teams = [Team]()
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
        dataRef.child("challenges").observe(.value, with: { (snapshot) in
            var challenges = [Challenge]()
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

    static func fetchAllChallengesOnce(completion: @escaping ([Challenge]) -> Void) { //fetches all challenges and returns them in an array through a completion
        dataRef.child("challenges").observeSingleEvent(of: .value, with: { (snapshot) in
            var challenges = [Challenge]()
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

    static func fetchAllUsers(completion: @escaping ([User]) -> Void) {
        dataRef.child("users").observe(.value, with: { (snapshot) in
            var users = [User]()
            let userDict = snapshot.value as? [String: Any]
            if let userDict = userDict {
                for user in userDict {
                    let userValues = user.value as? [String: Any] ?? [:]
                    let user = User(uid: user.key, dict: userValues)
                    users.append(user)
                }
            }
            completion(users)
        })

    }

    //    static func fetchPublicChallenges(completion: @escaping ([Challenge]) -> Void) {//fetches all public challenges and returns them through a completion
    //        var challenges = [Challenge]()
    //        dataRef.child("publicChallenges").observe(.value, with: { (snapshot) in
    //            let challengesDict = snapshot.value as? [String: Any]
    //            if let challengesDict = challengesDict {
    //                for challenge in challengesDict {
    //                    let challengeValues = challenge.value as? [String: Any] ?? [:]
    //                    let challenge = Challenge(id: challenge.key, dict: challengeValues)
    //                    challenges.append(challenge)
    //                }
    //            }
    //            completion(challenges)
    //        })
    //    }


    // MARK: - add new user/team/challenge functions
    private static func addNew(user: FIRUser) { //adds a new user's UID and email to the Firebase database
        FirebaseManager.dataRef.child("users").child(user.uid).child("email").setValue(user.email)
    }

    //adds an instance of Team to Firebase, and returns the auto generated teamID through a closure
    static func addNew(team: Team, completion: (String) -> Void) {
        let teamRef = dataRef.child("teams").childByAutoId()
        let teamID = teamRef.key
        let post = FirebaseManager.makeDictionary(fromTeam: team)
        teamRef.updateChildValues(post)
        completion(teamID)
    }

    static func addNew(challenge: Challenge, completion: (String) -> Void) {
        let challengeRef: FIRDatabaseReference = dataRef.child("challenges").childByAutoId()

        let challengeID = challengeRef.key

        let post = FirebaseManager.makeDictionary(fromChallenge: challenge)

        challengeRef.updateChildValues(post)
        completion(challengeID)
    }

    //    static func add(childID: String, toParentId parentID: String, parentDataType: DataType, childDataType: DataType, completion: () -> Void) {
    //        let parentRef = dataRef.child(parentDataType.rawValue).child(parentID)
    //        parentRef.child(childDataType.rawValue).child(childID).setValue(true)
    //        completion()
    //    }

    // MARK: - private helper functions
    private static func makeDictionary(fromTeam team: Team) -> [String: Any]{
        var usersDict = [String: Bool]()
        var challengesDict = [String: Bool]()

        for user in team.userUIDs {
            usersDict[user] = true
        }

        for challenge in team.challengeIDs {
            challengesDict[challenge] = true
        }

        let dict: [String: Any] = [
            "name": team.name,
            "captain": team.captainID,
            "users": usersDict,
            "challenges": challengesDict,
            ]
        return dict
    }

    private static func makeDictionary(fromChallenge challenge: Challenge) -> [String: Any] {
        var usersDict = [String: Bool]()
        var goalDict = [String: Double]()

        for (user, _) in challenge.userUIDs {
            usersDict[user] = true
        }

        if let goalType = challenge.goal?.type.rawValue, let goalValue = challenge.goal?.value {
            goalDict = [goalType: goalValue]
        }

        let teamID = challenge.teamID ?? "no team"

        let dict: [String: Any] = [
            "name": challenge.name,
            "users": usersDict,
            "creator": challenge.creator ?? "No Creator",
            "isPublic": challenge.isPublic,
            "startDate": challenge.startDate?.timeIntervalSince1970 ?? Date().timeIntervalSince1970,
            "endDate": challenge.endDate?.timeIntervalSince1970 ?? Date().timeIntervalSince1970,
            "team": teamID,
            "goal": goalDict
        ]

        return dict

    }


    static func add(childID: String, toParentId parentID: String, parentDataType: DataType, childDataType: DataType, completion: () -> Void) {
        let parentRef = dataRef.child(parentDataType.rawValue).child(parentID)
        parentRef.child(childDataType.rawValue).child(childID).setValue(true)
        completion()
    }



    static func checkForPrevious(uid: String, completion: @escaping (Bool) -> Void) {
        var check: Bool = false
        dataRef.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            let dictionary = snapshot.value as? [String: Any] ?? nil
            if dictionary != nil {check = true}
            completion(check)
        })
    }


    // MARK: test functions
    static func generateTestUser() {
        //        var user = User(name: "Superman", sex: "Male", height: 80, weight: 200, teamIDs: [], challengeIDs: [])
        //        //var user = User(name: "Batman", sex: "Bat", height: 74, weight: 240, teamIDs: [], challengeIDs: [])
        //        user.email = "batman@batman.com"
        //        FirebaseManager.createNew(withEmail: user.email!, withPassword: "batman1234") { (response) in
        //            switch response {
        //            case let .successfulNewUser(newUser):
        //                print("NEW USER CREATED with ID \(newUser)")
        //            default:
        //                print("could not create new user")
        //            }
        //
        //        }
    }



    static func loginTestUser () {
        FirebaseManager.loginUser(withEmail: "superman@superman.com", andPassword: "superman1234") { (response) in
            switch response {
            case let .successfulLogin(firUser):
                print("logged in user: \(firUser.email!)")
            default:
                print("could not log user in")
            }
        }
    }

    //MARK: remove functions

    static func remove(teamID: String, fromUID uid: String, completion: () -> Void) {
        dataRef.child("users").child(uid).child("teams").child(teamID).removeValue()
        dataRef.child("teams").child(teamID).child("users").child(uid).removeValue()
        completion()
    }

    static func delete(teamID: String, completion: () -> Void) {
        dataRef.child("teams").child(teamID).removeValue()
        completion()
    }

    static func hasUsers(inTeamID teamID: String, completion: @escaping (Bool) -> Void){
        dataRef.child("teams").child(teamID).child("users").observeSingleEvent(of: .value, with: { (snapshot) in
            if (snapshot.value as? [String: Any]) != nil {
                completion(true)
            } else {
                completion(false)
            }
        })
    }

    //MARK: Flag for offense

    static func flag(team: Team, completion: () -> Void) {
        guard let teamID = team.id else {return}
        dataRef.child("teams").child(teamID).child("flagged").setValue(true)
    }

    static func flag(user: User, completion: () -> Void) {
        guard let userID = user.uid else {return}
        dataRef.child("users").child(userID).child("flagged").setValue(true)
    }

    static func checkForFlag(onTeam team: Team, completion: @escaping (Bool) -> Void) {
        guard let teamID = team.id else {return}
        dataRef.child("teams").child(teamID).child("flagged").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let flagged = snapshot.value as? Bool else {

                completion(false)
                return
            }
            if flagged == true { //TODO: remove force unwrap with a default value
                completion(true)
            } else {
                completion(false)
            }

        })
    }

    static func checkForFlag(onUser user: User, completion: @escaping (Bool) -> Void) {
        guard let userID = user.uid else {return}
        dataRef.child("users").child(userID).child("flagged").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let flagged = snapshot.value as? Bool else {

                completion(false)
                return
            }
            if flagged == true { //TODO: remove force unwrap with a default value
                completion(true)
            } else {
                completion(false)
            }
        })
    }

    //MARK: - reset password

    static func resetPassword(forEmail email: String, completion: @escaping (Bool, Error?) -> ()) {
        FIRAuth.auth()?.sendPasswordReset(withEmail: email) { (error) in
            if error == nil {
                completion(true, nil)
            } else {
                completion(false, error)
            }
        }
    }

}
