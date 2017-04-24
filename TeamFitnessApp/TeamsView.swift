//
//  TeamsView.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/19/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import UIKit


protocol TeamsViewDelegate: class {
    func segueCreateTeam ()
}


class TeamsView: FitnessView {

    var myTeamsLabel: TitleLabel!
    var findTeamsLabel: TitleLabel!
    var createTeamLabel: TitleLabel!
    var createTeamButton: FitnessButton!
    var teamSearchBar: UISearchBar!
    var myTeamsView: UITableView!
    var searchTableView: UITableView!
    weak var delegate: TeamsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        comInit()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      comInit()
      setConstraints()
    }

    func segueCreateTeam(sender: UIButton) {
        delegate?.segueCreateTeam()
    }

    func comInit() {
        myTeamsLabel = TitleLabel()
        self.addSubview(myTeamsLabel)
        myTeamsLabel.translatesAutoresizingMaskIntoConstraints = false
        myTeamsLabel.set(text: "My Teams")
        myTeamsLabel.changeFontSize(to: 20)

        myTeamsView = UITableView()
        self.addSubview(myTeamsView)
        myTeamsView.translatesAutoresizingMaskIntoConstraints = false
        myTeamsView.backgroundColor = UIColor.clear

        findTeamsLabel = TitleLabel()
        self.addSubview(findTeamsLabel)
        findTeamsLabel.translatesAutoresizingMaskIntoConstraints = false
        findTeamsLabel.set(text: "Find Teams")
        findTeamsLabel.changeFontSize(to: 20)

        teamSearchBar = UISearchBar()
        self.addSubview(teamSearchBar)
        teamSearchBar.translatesAutoresizingMaskIntoConstraints = false
        teamSearchBar.placeholder = "Find Teams by Name"
        teamSearchBar.setPlaceholderAttributes()
        teamSearchBar.setTextAttributes()
        teamSearchBar.searchBarStyle = .minimal
        
        searchTableView = UITableView()
        self.addSubview(searchTableView)
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        searchTableView.backgroundColor = UIColor.clear

        createTeamLabel = TitleLabel()
        self.addSubview(createTeamLabel)
        createTeamLabel.translatesAutoresizingMaskIntoConstraints = false
        createTeamLabel.set(text: "...or...")
        createTeamLabel.changeFontSize(to: 20)


        createTeamButton = FitnessButton()
        self.addSubview(createTeamButton)
        createTeamButton.translatesAutoresizingMaskIntoConstraints = false
        createTeamButton.set(text: "create team")
        createTeamButton.addTarget(self, action: #selector(segueCreateTeam), for: .touchUpInside)
    }
    
    func setConstraints() {
        myTeamsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 70).isActive = true
        myTeamsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        myTeamsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        myTeamsLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.03).isActive = true

        myTeamsView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        myTeamsView.topAnchor.constraint(equalTo: myTeamsLabel.bottomAnchor, constant: 2).isActive = true
        myTeamsView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        myTeamsView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.20).isActive = true

        findTeamsLabel.topAnchor.constraint(equalTo: myTeamsView.bottomAnchor, constant: 10).isActive = true
        findTeamsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        findTeamsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        findTeamsLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.03).isActive = true

        teamSearchBar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        teamSearchBar.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.10).isActive = true
        teamSearchBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        teamSearchBar.topAnchor.constraint(equalTo: findTeamsLabel.bottomAnchor, constant: 3).isActive = true
        
        searchTableView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        searchTableView.topAnchor.constraint(equalTo: teamSearchBar.bottomAnchor, constant: 5).isActive = true
        searchTableView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        searchTableView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true

        createTeamLabel.topAnchor.constraint(equalTo: searchTableView.bottomAnchor, constant: 10).isActive = true
        createTeamLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        createTeamLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        createTeamLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07).isActive = true

        createTeamButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        createTeamButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        createTeamButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        createTeamButton.topAnchor.constraint(equalTo: createTeamLabel.bottomAnchor, constant: 10).isActive = true
    }
}
