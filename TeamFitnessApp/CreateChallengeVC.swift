//
//  CreateChallengeVC.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/10/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class CreateChallengeVC: UIViewController {

    let titleLabel = TitleLabel()
    let teamSearchBar = UISearchBar()
    let publicButton = FitnessButton()
    var challengeIsPublic: Bool = false
    var team: Team? = nil
    
    var myTeams = [Team]()
    var filteredTeams = [Team]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = FitnessView()
        setupViews()
        
    }
    
    func setupViews() {
        self.view.addSubview(titleLabel)
        titleLabel.setConstraints(toView: self.view)
        titleLabel.setText(toString: "New Challenge")
        
        self.view.addSubview(teamSearchBar)
        teamSearchBar.translatesAutoresizingMaskIntoConstraints = false
        teamSearchBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        teamSearchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        teamSearchBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        teamSearchBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        teamSearchBar.placeholder = "Team to add challenge to:"
        teamSearchBar.backgroundColor = UIColor.foregroundOrange
        
        self.view.addSubview(publicButton)
        publicButton.translatesAutoresizingMaskIntoConstraints = false
        publicButton.topAnchor.constraint(equalTo: teamSearchBar.topAnchor).isActive = true
        publicButton.rightAnchor.constraint(equalTo: teamSearchBar.leftAnchor, constant: -10).isActive = true
        publicButton.heightAnchor.constraint(equalTo: teamSearchBar.heightAnchor).isActive = true
        publicButton.widthAnchor.constraint(equalTo: publicButton.heightAnchor).isActive = true
        publicButton.reverseColors()
        publicButton.setTitle("Public?", for: .normal)
        publicButton.addTarget(self, action: #selector(publicButtonPressed), for: .touchUpInside)
        teamSearchBar.isUserInteractionEnabled = true
        teamSearchBar.alpha = 1.0
        print("public button frame: \(publicButton.frame)")

    }
    
    func publicButtonPressed() { //switch the 'public button' to on or off. If public button is on, turn off the search bar, and vice versa
        if challengeIsPublic {
            publicButton.reverseColors()
            teamSearchBar.isUserInteractionEnabled = true
            teamSearchBar.alpha = 1.0
            challengeIsPublic = false
        } else {
            publicButton.backgroundColor = UIColor.foregroundOrange
            publicButton.setTitleColor(UIColor.backgroundBlack, for: .normal)
            teamSearchBar.isUserInteractionEnabled = false
            teamSearchBar.alpha = 0.5
            challengeIsPublic = true
        }
    }

}
