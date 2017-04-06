//
//  TeamDetailVC.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class TeamDetailVC: UIViewController {

    var team: Team?
    let teamNameLabel = FitnessLabel()
    let captainLabel = FitnessLabel()
    let membersLabel = FitnessLabel()
    let challengesLabel = FitnessLabel()
    let inviteMembersButton = FitnessButton()
    
    let membersView = UITableView()
    let challengesView = UITableView()
    
    let teamImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    func setupViews() {
        view = FitnessView()
        
        self.view.addSubview(teamNameLabel)
        teamNameLabel.translatesAutoresizingMaskIntoConstraints = false
        teamNameLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        teamNameLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 25).isActive = true
        teamNameLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        teamNameLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        teamNameLabel.textAlignment = .center
        teamNameLabel.changeFontSize(to: 28)
        teamNameLabel.reverseColors()
        
        if let captain = team?.captain { //get the captain and set their name to the captain label
            FirebaseManager.fetchUser(withUID: captain, completion: { (captain) in
                self.captainLabel.text = "Captain: \(captain.name)"
            })
        }
        self.view.addSubview(captainLabel)
        captainLabel.translatesAutoresizingMaskIntoConstraints = false
        captainLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        captainLabel.topAnchor.constraint(equalTo: teamNameLabel.bottomAnchor).isActive = true
        captainLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        captainLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        captainLabel.textAlignment = .center
        captainLabel.changeFontSize(to: 20)
        captainLabel.reverseColors()
        
        self.view.addSubview(membersLabel)
        membersLabel.translatesAutoresizingMaskIntoConstraints = false
        membersLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        membersLabel.topAnchor.constraint(equalTo: captainLabel.bottomAnchor, constant: 25).isActive = true
        membersLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        membersLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        membersLabel.textAlignment = .center
        membersLabel.changeFontSize(to: 18)
        membersLabel.reverseColors()
        membersLabel.text = "Members:"
        
        self.view.addSubview(membersView)
        membersView.translatesAutoresizingMaskIntoConstraints = false
        membersView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        membersView.topAnchor.constraint(equalTo: membersLabel.bottomAnchor).isActive = true
        membersView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        membersView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
        membersView.backgroundColor = UIColor.foregroundOrange
        
        self.view.addSubview(challengesLabel)
        challengesLabel.translatesAutoresizingMaskIntoConstraints = false
        challengesLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        challengesLabel.topAnchor.constraint(equalTo: membersView.bottomAnchor, constant: 25).isActive = true
        challengesLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        challengesLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        challengesLabel.changeFontSize(to: 18)
        challengesLabel.textAlignment = .center
        challengesLabel.reverseColors()
        challengesLabel.text = "Challenges:"
        
        self.view.addSubview(challengesView)
        challengesView.translatesAutoresizingMaskIntoConstraints = false
        challengesView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        challengesView.topAnchor.constraint(equalTo: challengesLabel.bottomAnchor).isActive = true
        challengesView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        challengesView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
        challengesView.backgroundColor = UIColor.foregroundOrange
    }

    func setTeam(team: Team) {
        self.team = team
        teamNameLabel.text = team.name
    }
}
