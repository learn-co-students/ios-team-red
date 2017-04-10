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
        teamNameLabel.setConstraints(toView: self.view)
        
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
                default:
                    print("Invalid Firebase response")
                }
            }
        } else {
            //TODO: - replace image with default image
        }
        
        self.view.addSubview(captainLabel)
        if let captain = team?.captainID { //get the captain and set their name to the captain label
            FirebaseManager.fetchUser(withFirebaseUID: captain, completion: { (captain) in
                self.captainLabel.text = "Captain: \(captain.name)"
            })
        }
        captainLabel.translatesAutoresizingMaskIntoConstraints = false
        captainLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        captainLabel.topAnchor.constraint(equalTo: teamImageView.bottomAnchor).isActive = true
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
        membersView.backgroundColor = UIColor.clear
        
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
        challengesView.backgroundColor = UIColor.clear
    }
}
