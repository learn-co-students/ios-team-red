//
//  TeamDetailVCExtension.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/7/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import UIKit

extension TeamDetailVC {
    func setupViews() {
        view = FitnessView()
        
        self.view.addSubview(teamNameLabel)
        teamNameLabel.setConstraints(toView: self.view, andViewController: self)
        
        view.addSubview(teamImageView)
        teamImageView.translatesAutoresizingMaskIntoConstraints = false
        teamImageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        teamImageView.topAnchor.constraint(equalTo: teamNameLabel.bottomAnchor).isActive = true
        teamImageView.widthAnchor.constraint(equalTo: teamNameLabel.widthAnchor, multiplier: 0.35).isActive = true
        teamImageView.heightAnchor.constraint(equalTo: teamImageView.widthAnchor).isActive = true
        teamImageView.backgroundColor = UIColor.foregroundOrange
        if let team = self.team {
            FirebaseStoreageManager.downloadImage(forTeam: team) { (response) in //download image for team and set it = to teamImageView
                switch response {
                case let .successfulDownload(teamImage):
                    DispatchQueue.main.async {
                        self.teamImageView.image = teamImage
                    }
                case let .failure(failString):
                    print(failString)
                    self.teamImageView.image = #imageLiteral(resourceName: "defaultTeam")
                default:
                    print("Invalid Firebase response")
                }
            }
        } else {
            self.teamImageView.image = #imageLiteral(resourceName: "defaultTeam")
        }
        
        self.view.addSubview(captainLabel)
        if let captain = team?.captainID { //get the captain and set their name to the captain label
            FirebaseManager.fetchUser(withFirebaseUID: captain, completion: { (captain) in
                self.captainLabel.text = "Captain: \(captain.name)"
            })
        }
        captainLabel.constrainVertically(belowView: teamImageView, widthMultiplier: 0.5, heightMultiplier: 0.05)
        captainLabel.textAlignment = .center
        captainLabel.changeFontSize(to: 20)
        captainLabel.reverseColors()
        
        if !userIsTeamMember {
            self.view.addSubview(joinButton)
            joinButton.translatesAutoresizingMaskIntoConstraints = false
            joinButton.leftAnchor.constraint(equalTo: captainLabel.rightAnchor).isActive = true
            joinButton.topAnchor.constraint(equalTo: captainLabel.topAnchor).isActive = true
            joinButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
            joinButton.heightAnchor.constraint(equalTo: joinButton.widthAnchor).isActive = true
            joinButton.setTitle("Join Team", for: .normal)
            joinButton.addTarget(self, action: #selector(joinTeam), for: .touchUpInside)
        }
        
        self.view.addSubview(membersLabel)
        membersLabel.constrainVertically(belowView: captainLabel, widthMultiplier: 0.8, heightMultiplier: 0.05)
        membersLabel.textAlignment = .center
        membersLabel.changeFontSize(to: 18)
        membersLabel.reverseColors()
        membersLabel.text = "Members:"
        
        self.view.addSubview(membersView)
        membersView.constrainVertically(belowView: membersLabel, widthMultiplier: 0.8, heightMultiplier: 0.25)
        membersView.backgroundColor = UIColor.clear
        
        self.view.addSubview(challengesLabel)
        challengesLabel.constrainVertically(belowView: membersView, widthMultiplier: 0.8, heightMultiplier: 0.05)
        challengesLabel.changeFontSize(to: 18)
        challengesLabel.textAlignment = .center
        challengesLabel.reverseColors()
        challengesLabel.text = "Challenges:"
        
        self.view.addSubview(challengesView)
        challengesView.constrainVertically(belowView: challengesLabel, widthMultiplier: 0.8, heightMultiplier: 0.25)
        challengesView.backgroundColor = UIColor.clear
        
        if userIsCaptain {
            self.view.addSubview(createChallengeButton)
            createChallengeButton.translatesAutoresizingMaskIntoConstraints = false
            createChallengeButton.leftAnchor.constraint(equalTo: challengesLabel.rightAnchor).isActive = true
            createChallengeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
            createChallengeButton.topAnchor.constraint(equalTo: challengesLabel.topAnchor).isActive = true
            createChallengeButton.bottomAnchor.constraint(equalTo: challengesLabel.bottomAnchor).isActive = true
            createChallengeButton.setTitle("+", for: .normal)
            createChallengeButton.addTarget(self, action: #selector(segueCreateChallenge), for: .touchUpInside)
        }
    }
}
