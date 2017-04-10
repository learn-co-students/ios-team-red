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
        titleLabel.setText(toString: "Create Challenge")
        
        self.view.addSubview(teamSearchBar)
        teamSearchBar.translatesAutoresizingMaskIntoConstraints = true
        teamSearchBar.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        teamSearchBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        teamSearchBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        teamSearchBar.placeholder = "Team to add challenge to:"
        teamSearchBar.backgroundColor = UIColor.foregroundOrange
        
        self.view.addSubview(publicButton)
        publicButton.translatesAutoresizingMaskIntoConstraints = true
        publicButton.topAnchor.constraint(equalTo: teamSearchBar.topAnchor).isActive = true
        publicButton.heightAnchor.constraint(equalTo: teamSearchBar.heightAnchor).isActive = true
        publicButton.rightAnchor.constraint(equalTo: teamSearchBar.leftAnchor).isActive = true
        publicButton.widthAnchor.constraint(equalTo: publicButton.widthAnchor).isActive = true
        publicButton.reverseColors()
        publicButton.setTitle("Public?", for: .normal)
        publicButton.addTarget(self, action: #selector(publicButtonPressed), for: .touchUpInside)

    }
    
    func publicButtonPressed() {
        if challengeIsPublic {
            challengeIsPublic = false
            publicButton.reverseColors()
        } else {
            challengeIsPublic = true
            publicButton.backgroundColor = UIColor.foregroundOrange
            publicButton.titleLabel?.textColor = UIColor.backgroundBlack
        }
    }

}
