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
    }

    func setTeam(team: Team) {
        self.team = team
        teamNameLabel.text = team.name
    }
}
