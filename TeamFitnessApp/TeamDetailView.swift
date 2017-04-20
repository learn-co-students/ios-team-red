//
//  TeamDetailView.swift
//  TeamFitnessApp
//

//  Created by Alessandro Musto on 4/19/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class TeamDetailView: FitnessView {
    
    
    var teamNameLabel: TitleLabel!
    var captainLabel: FitnessLabel!
    var membersLabel: FitnessLabel!
    var challengesLabel: FitnessLabel!
    var inviteMembersButton: FitnessButton!
    var createChallengeButton: FitnessButton!
    var membersView: UITableView!
    var challengesView: UITableView!
    var joinButton: FitnessButton!
    var teamImageView: UIImageView!

    var reportButton: ReportButton!

    var leaveTeamButton: FitnessButton!

    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        comInit()
        setConstrains()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        comInit()
        setConstrains()
    }
    
    func comInit() {
        
        
        teamNameLabel = TitleLabel()
        teamNameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(teamNameLabel)
        
        teamImageView = UIImageView()
        self.addSubview(teamImageView)
        teamImageView.translatesAutoresizingMaskIntoConstraints = false
        teamImageView.backgroundColor = UIColor.clear
        

        reportButton = ReportButton()
        self.addSubview(reportButton)
        reportButton.translatesAutoresizingMaskIntoConstraints = false

        leaveTeamButton = FitnessButton()
        self.addSubview(leaveTeamButton)
        leaveTeamButton.translatesAutoresizingMaskIntoConstraints = false
        leaveTeamButton.setTitle("Leave team", for: .normal)

        
        captainLabel = FitnessLabel()
        self.addSubview(captainLabel)
        captainLabel.translatesAutoresizingMaskIntoConstraints = false
        captainLabel.textAlignment = .center
        captainLabel.changeFontSize(to: 20)
        captainLabel.reverseColors()
        
        joinButton = FitnessButton()
        self.addSubview(joinButton)
        joinButton.setTitle("Join Team", for: .normal)
        joinButton.translatesAutoresizingMaskIntoConstraints = false
        
        membersLabel = FitnessLabel()
        membersLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(membersLabel)
        membersLabel.textAlignment = .center
        membersLabel.changeFontSize(to: 18)
        membersLabel.reverseColors()
        membersLabel.text = "Members:"
        
        membersView = UITableView()
        self.addSubview(membersView)
        membersView.translatesAutoresizingMaskIntoConstraints = false
        membersView.backgroundColor = UIColor.clear
        
        challengesLabel = FitnessLabel()
        challengesLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(challengesLabel)
        challengesLabel.changeFontSize(to: 18)
        challengesLabel.textAlignment = .center
        challengesLabel.reverseColors()
        challengesLabel.text = "Challenges:"
        
        challengesView = UITableView()
        challengesView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(challengesView)
        challengesView.backgroundColor = UIColor.clear
        
        
        createChallengeButton = FitnessButton()
        createChallengeButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(createChallengeButton)
        createChallengeButton.translatesAutoresizingMaskIntoConstraints = false
        createChallengeButton.setTitle("+", for: .normal)
        
    }
    
    
    func setConstrains() {
        
        teamNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        teamNameLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: 0).isActive = true
        teamNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 75).isActive = true
        teamNameLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        teamImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        teamImageView.topAnchor.constraint(equalTo: teamNameLabel.bottomAnchor).isActive = true
        teamImageView.widthAnchor.constraint(equalTo: teamNameLabel.widthAnchor, multiplier: 0.35).isActive = true
        teamImageView.heightAnchor.constraint(equalTo: teamImageView.widthAnchor).isActive = true
        
        reportButton.topAnchor.constraint(equalTo: teamImageView.topAnchor).isActive = true
        reportButton.bottomAnchor.constraint(equalTo: teamImageView.bottomAnchor).isActive = true
        reportButton.rightAnchor.constraint(equalTo: teamImageView.leftAnchor).isActive = true
        reportButton.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        
        captainLabel.constrainVertically(belowView: teamImageView, widthMultiplier: 0.5, heightMultiplier: 0.05)
        
        joinButton.leftAnchor.constraint(equalTo: captainLabel.rightAnchor).isActive = true
        joinButton.topAnchor.constraint(equalTo: captainLabel.topAnchor).isActive = true
        joinButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.2).isActive = true
        joinButton.heightAnchor.constraint(equalTo: joinButton.widthAnchor).isActive = true
        

        leaveTeamButton.centerYAnchor.constraint(equalTo: joinButton.centerYAnchor).isActive = true
        leaveTeamButton.centerXAnchor.constraint(equalTo: joinButton.centerXAnchor).isActive = true
        leaveTeamButton.heightAnchor.constraint(equalTo: joinButton.heightAnchor).isActive = true
        leaveTeamButton.widthAnchor.constraint(equalTo: joinButton.widthAnchor).isActive = true
        

        membersLabel.constrainVertically(belowView: captainLabel, widthMultiplier: 0.8, heightMultiplier: 0.05)
        
        membersView.constrainVertically(belowView: membersLabel, widthMultiplier: 0.8, heightMultiplier: 0.25)
        
        challengesLabel.constrainVertically(belowView: membersView, widthMultiplier: 0.8, heightMultiplier: 0.05)
        
        challengesView.constrainVertically(belowView: challengesLabel, widthMultiplier: 0.8, heightMultiplier: 0.25)
        
        createChallengeButton.leftAnchor.constraint(equalTo: challengesLabel.rightAnchor).isActive = true
        createChallengeButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        createChallengeButton.topAnchor.constraint(equalTo: challengesLabel.topAnchor).isActive = true
        createChallengeButton.bottomAnchor.constraint(equalTo: challengesLabel.bottomAnchor).isActive = true
        
    }
}
