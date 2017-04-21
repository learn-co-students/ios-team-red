 //
 //  TeamDetailVC.swift
 //  TeamFitnessApp
 //
 //  Created by Patrick O'Leary on 4/6/17.
 //  Copyright © 2017 Patrick O'Leary. All rights reserved.
 //
 
 import UIKit
 import Firebase
 
 class TeamDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var teamDetailView: TeamDetailView!
    var team: Team?
    var uid: String? = FIRAuth.auth()?.currentUser?.uid
    
    var teamUsers = [User]()
    var teamChallenges = [Challenge]()
    
    
    var userIsTeamMember: Bool {
        var test = false
        guard let UIDs = team?.userUIDs, let uid = self.uid else {return test}
        if UIDs.contains(uid) {test = true}
        return test
    }
    
    var userIsCaptain: Bool {
        return team?.captainID == FIRAuth.auth()?.currentUser?.uid
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setTitle(text: (self.team?.name)!)
        
        
        teamDetailView = TeamDetailView(frame: view.frame)
        self.view = teamDetailView
        
        teamDetailView.membersView.register(FitnessCell.self, forCellReuseIdentifier: "fitnessCell")
        teamDetailView.membersView.delegate = self
        teamDetailView.membersView.dataSource = self
        
        teamDetailView.challengesView.register(FitnessCell.self, forCellReuseIdentifier: "fitnessCell")
        teamDetailView.challengesView.delegate = self
        teamDetailView.challengesView.dataSource = self
        
        teamDetailView.joinButton.isHidden = true
        teamDetailView.joinButton.isEnabled = false
        teamDetailView.joinButton.addTarget(self, action: #selector(joinTeam), for: .touchUpInside)
        
        teamDetailView.leaveTeamButton.isHidden = false
        teamDetailView.leaveTeamButton.isEnabled = true
        teamDetailView.leaveTeamButton.addTarget(self, action: #selector(leaveTeam), for: .touchUpInside)
        
        
        
        if !userIsTeamMember {
            teamDetailView.joinButton.isHidden = false
            teamDetailView.joinButton.isEnabled = true
            teamDetailView.leaveTeamButton.isHidden = true
            teamDetailView.leaveTeamButton.isEnabled = false
        }
        
        teamDetailView.createChallengeButton.isHidden = true
        teamDetailView.createChallengeButton.isEnabled = false
        teamDetailView.createChallengeButton.addTarget(self, action: #selector(segueCreateChallenge), for: .touchUpInside)
        
        if userIsCaptain {
            teamDetailView.createChallengeButton.isHidden = false
            teamDetailView.createChallengeButton.isEnabled = true
        }
        
        
        
        if let team = self.team {
            FirebaseStoreageManager.downloadImage(forTeam: team) { (response) in //download image for team and set it = to teamImageView
                switch response {
                case let .successfulDownload(teamImage):
                    DispatchQueue.main.async {
                        self.teamDetailView.teamImageView.image = teamImage
                    }
                case let .failure(failString):
                    print(failString)
                    self.teamDetailView.teamImageView.image = #imageLiteral(resourceName: "defaultTeam")
                default:
                    print("Invalid Firebase response")
                }
            }
        } else {
            self.teamDetailView.teamImageView.image = #imageLiteral(resourceName: "defaultTeam")
        }
        
        if let captain = team?.captainID { //get the captain and set their name to the captain label
            FirebaseManager.fetchUser(withFirebaseUID: captain, completion: { (captain) in
                self.teamDetailView.captainLabel.set(text: "Captain: \(captain.name)")
            })
        }
        
        
        DataStore.sharedInstance.observeAllUsers() {
            self.getTeamMembers {
                self.teamDetailView.membersView.reloadData()
            }
        }
        
        DataStore.sharedInstance.observeAllChallenges { 
            self.getTeamChallenges {
                self.teamDetailView.challengesView.reloadData()
            }
        }
    }
    
    
    
    func setTeam(team: Team) {
        self.team = team
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        
        if tableView == teamDetailView.membersView {
            rows = teamUsers.count
        } else if tableView == teamDetailView.challengesView {
            rows = teamChallenges.count
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = FitnessCell()
        if tableView == teamDetailView.membersView {
            cell = teamDetailView.membersView.dequeueReusableCell(withIdentifier: "fitnessCell") as! FitnessCell //TODO set default cell layout
            guard teamUsers.count > 0 else {return cell}
            cell.setLabels(forUser: teamUsers[indexPath.row])
        } else if tableView == teamDetailView.challengesView {
            cell = teamDetailView.challengesView.dequeueReusableCell(withIdentifier: "fitnessCell") as! FitnessCell
            guard teamChallenges.count > 0 else {return cell}
            cell.setLabels(forChallenge: teamChallenges[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let challengeDetailVC = ChallengeDetailVC()
        if tableView == teamDetailView.challengesView {
            challengeDetailVC.setChallenge(challenge: teamChallenges[indexPath.row])
            navigationController?.pushViewController(challengeDetailVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - calls to firebase
    
//    func observeTeamData(completion: @escaping () -> Void) {
//        guard let teamID = self.team?.id else {return}
//        FirebaseManager.fetchTeam(withTeamID: teamID) { (team) in
//            self.team = team
//            self.fetchChallenges(forTeam: team) {
//                DispatchQueue.main.async {
//                    self.teamDetailView.challengesView.reloadData()
//                }
//            }
//            self.fetchUsers(forTeam: team) {
//                    DispatchQueue.main.async {
//                        self.teamDetailView.membersView.reloadData()
//                }
//            }
//            
//        }
//    }
    
//    private func fetchChallenges(forTeam team: Team, completion: @escaping () -> Void) {
//        self.teamChallenges.removeAll()
//        for challengeID in team.challengeIDs {
//            FirebaseManager.fetchChallengeOnce(withChallengeID: challengeID, completion: { (challenge) in
//                self.teamChallenges.append(challenge)
//                completion()
//            })
//        }
//    }
    
    private func getTeamChallenges(completion: () -> Void) {
        self.teamChallenges.removeAll()
        for challenge in DataStore.sharedInstance.allChallenges {
            if challenge.teamID == self.team?.id {
                self.teamChallenges.append(challenge)
            }
        }
        completion()
    }
    
    private func getTeamMembers(completion: @escaping () -> Void) {
        if let team = self.team {
            self.teamUsers.removeAll()
            for user in DataStore.sharedInstance.allUsers {
                guard let uid = user.uid else {return}
                if team.userUIDs.contains(uid) {
                    self.teamUsers.append(user)
                }
            }
            completion()
        }
    }
    
//    private func fetchUsers(forTeam team: Team, completion: @escaping () -> Void) {
//        self.teamUsers.removeAll()
//        for uid in team.userUIDs {
//            FirebaseManager.fetchUserOnce(withFirebaseUID: uid, completion: { (user) in
//                self.teamUsers.append(user)
//                completion()
//            })
//        }
//    }
    
    
    //MARK: - Button functions
    
    func joinTeam() {
        guard let uid = self.uid, let teamID = self.team?.id else {return} //TODO: handle this error better
        
        FirebaseManager.add(childID: uid, toParentId: teamID, parentDataType: .teams, childDataType: .users) {
            self.teamUsers.removeAll()
            self.teamChallenges.removeAll()
            FirebaseManager.add(childID: teamID, toParentId: uid, parentDataType: .users, childDataType: .teams) {
                DispatchQueue.main.async {
                    self.teamDetailView.membersView.reloadData()
                    self.teamDetailView.challengesView.reloadData()
                }
            }
        }
        teamDetailView.joinButton.isHidden = true
        teamDetailView.leaveTeamButton.isEnabled = true
        teamDetailView.leaveTeamButton.isHidden = false
    }
    
    func segueCreateChallenge() {
        let createChallengeVC = CreateChallengeVC()
        createChallengeVC.team = self.team
        createChallengeVC.challengeIsPublic = false
        let navVC = NavigationController(rootViewController: createChallengeVC)
        present(navVC, animated: true, completion: nil)
    }
    
    func leaveTeam() {
        guard let teamID = team?.id, let uid = self.uid else {return}
        FirebaseManager.remove(teamID: teamID, fromUID: uid) {
            teamDetailView.leaveTeamButton.isHidden = true
            teamDetailView.joinButton.isHidden = false
            teamDetailView.joinButton.isEnabled = true
            checkIfTeamIsEmpty()
            
        }
    }
    
    private func checkIfTeamIsEmpty() {
        guard let teamID = team?.id else {return}
        FirebaseManager.hasUsers(inTeamID: teamID) { (teamHasUsers) in
            if !teamHasUsers {
                FirebaseManager.delete(teamID: teamID, completion: {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                })
            }
        }
    }
    
 }
