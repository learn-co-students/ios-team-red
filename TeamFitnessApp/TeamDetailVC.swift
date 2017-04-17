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

    var team: Team?
    let teamNameLabel = TitleLabel()
    let captainLabel = FitnessLabel()
    let membersLabel = FitnessLabel()
    let challengesLabel = FitnessLabel()
    let inviteMembersButton = FitnessButton()
    let createChallengeButton = FitnessButton()
    let teamImageView = UIImageView()
    var uid: String? = FIRAuth.auth()?.currentUser?.uid
    
    var teamUsers = [User]()
    var teamChallenges = [Challenge]()
    
    let membersView = UITableView()
    let challengesView = UITableView()
    let joinButton = FitnessButton()
    
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
        
        membersView.register(FitnessCell.self, forCellReuseIdentifier: "fitnessCell")
        membersView.delegate = self
        membersView.dataSource = self
        
        challengesView.register(FitnessCell.self, forCellReuseIdentifier: "fitnessCell")
        challengesView.delegate = self
        challengesView.dataSource = self

        setupViews()
        
        observeTeamData() {}
    }
    
    func setTeam(team: Team) {
        self.team = team
        teamNameLabel.text = team.name
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        
        if tableView == membersView {
            rows = teamUsers.count
        } else if tableView == challengesView {
            rows = teamChallenges.count
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = FitnessCell()
        if tableView == membersView {
            cell = membersView.dequeueReusableCell(withIdentifier: "fitnessCell") as! FitnessCell //TODO set default cell layout
            cell.setLabels(forUser: teamUsers[indexPath.row])
        } else if tableView == challengesView {
            cell = challengesView.dequeueReusableCell(withIdentifier: "fitnessCell") as! FitnessCell
            cell.setLabels(forChallenge: teamChallenges[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let challengeDetailVC = ChallengeDetailVC()
        if tableView == challengesView {
            challengeDetailVC.setChallenge(challenge: teamChallenges[indexPath.row])
            navigationController?.pushViewController(challengeDetailVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
// MARK: - calls to firebase
    
    func observeTeamData(completion: @escaping () -> Void) {
        guard let teamID = self.team?.id else {return}
        FirebaseManager.fetchTeam(withTeamID: teamID) { (team) in
            self.team = team
            self.fetchChallenges(forTeam: team) {
                DispatchQueue.main.async {
                    self.challengesView.reloadData()
                }
            }
            self.fetchUsers(forTeam: team) {
                DispatchQueue.main.async {
                    self.membersView.reloadData()
                }
            }
            
        }
    }
    
    private func fetchChallenges(forTeam team: Team, completion: @escaping () -> Void) {
        self.teamChallenges.removeAll()
        for challengeID in team.challengeIDs {
            FirebaseManager.fetchChallengeOnce(withChallengeID: challengeID, completion: { (challenge) in
                self.teamChallenges.append(challenge)
                completion()
            })
        }
    }
    
    private func fetchUsers(forTeam team: Team, completion: @escaping () -> Void) {
        self.teamUsers.removeAll()
        for uid in team.userUIDs {
            FirebaseManager.fetchUserOnce(withFirebaseUID: uid, completion: { (user) in
                self.teamUsers.append(user)
                completion()
            })
        }
    }
    
    
//MARK: - Button functions
    
    func joinTeam() {
        guard let uid = self.uid, let teamID = self.team?.id else {return} //TODO: handle this error better
        
        FirebaseManager.add(childID: uid, toParentId: teamID, parentDataType: .teams, childDataType: .users) {
            self.teamUsers.removeAll()
            self.teamChallenges.removeAll()
            FirebaseManager.add(childID: teamID, toParentId: uid, parentDataType: .users, childDataType: .teams) {
                DispatchQueue.main.async {
                    self.membersView.reloadData()
                    self.challengesView.reloadData()
                }
            }
        }
        joinButton.isHidden = true
    }
    
    func segueCreateChallenge() {
        let createChallengeVC = CreateChallengeVC()
        createChallengeVC.team = self.team
        present(createChallengeVC, animated: true, completion: nil)
    }
}
