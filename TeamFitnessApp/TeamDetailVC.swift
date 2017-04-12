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
    var teamUsers = [User]()
    var teamChallenges = [Challenge]()
    let teamNameLabel = TitleLabel()
    let captainLabel = FitnessLabel()
    let membersLabel = FitnessLabel()
    let challengesLabel = FitnessLabel()
    let inviteMembersButton = FitnessButton()
    let createChallengeButton = FitnessButton()
    let teamImageView = UIImageView()
    
    let membersView = UITableView()
    let challengesView = UITableView()
    
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
        
        getTeamMembers(forTeam: team) {
            self.membersView.reloadData()
        }
        
        getTeamChallenges(forTeam: team) {
            self.challengesView.reloadData()
        }
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
            return teamChallenges.count
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
    
// MARK: - calls to firebase
    func getTeamMembers(forTeam team: Team?, completion: @escaping () -> Void) {
        teamUsers.removeAll()
        if let memberList = team?.userUIDs {
            for memberID in memberList {
                FirebaseManager.fetchUser(withFirebaseUID: memberID, completion: { (user) in
                    self.teamUsers.append(user)
                    completion()
                })
            }
        }
    }
    
    func getTeamChallenges(forTeam team: Team?, completion: @escaping () -> Void) {
        teamChallenges.removeAll()
        if let challengeList = team?.challengeIDs {
            for challengeID in challengeList {
                FirebaseManager.fetchChallenge(withChallengeID: challengeID, completion: { (challenge) in
                    self.teamChallenges.append(challenge)
                    completion()
                })
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let challengeDetailVC = ChallengeDetailVC()
        if tableView == challengesView {
            challengeDetailVC.setChallenge(challenge: teamChallenges[indexPath.row])
            present(challengeDetailVC, animated: true, completion: nil)
        }
    }
    
    func segueCreateChallenge() {
        let createChallengeVC = CreateChallengeVC()
        present(createChallengeVC, animated: true, completion: nil)
    }
}
