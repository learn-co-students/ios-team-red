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
    var createTeamButton: FitnessButton!
    var teamSearchBar: UISearchBar!
    var myTeamsView: UITableView!
    var searchTableView: UITableView!
    weak var delegate: TeamsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        comInit()
        setConstaints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func segueCreateTeam(sender: UIButton) {
        delegate?.segueCreateTeam()
    }

    
    
    func comInit() {
        
        myTeamsLabel = TitleLabel()
        self.addSubview(myTeamsLabel)
        myTeamsLabel.translatesAutoresizingMaskIntoConstraints = false
        myTeamsLabel.setText(toString: "My Teams")

        myTeamsView = UITableView()
        self.addSubview(myTeamsView)
        myTeamsView.translatesAutoresizingMaskIntoConstraints = false
        myTeamsView.backgroundColor = UIColor.clear

        teamSearchBar = UISearchBar()
        self.addSubview(teamSearchBar)
        teamSearchBar.translatesAutoresizingMaskIntoConstraints = false
        teamSearchBar.placeholder = "Find Teams by Name:"
        teamSearchBar.searchBarStyle = .minimal
        
        searchTableView = UITableView()
        self.addSubview(searchTableView)
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        searchTableView.backgroundColor = UIColor.clear

        createTeamButton = FitnessButton()
        self.addSubview(createTeamButton)
        createTeamButton.translatesAutoresizingMaskIntoConstraints = false
        createTeamButton.setTitle("+", for: .normal)
        createTeamButton.changeFontSize(to: 18)
        createTeamButton.addTarget(self, action: #selector(segueCreateTeam), for: .touchUpInside)
    }
    
    func setConstaints() {
        
        myTeamsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 75).isActive = true
        myTeamsLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        myTeamsLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        myTeamsLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
        
        myTeamsView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        myTeamsView.topAnchor.constraint(equalTo: myTeamsLabel.bottomAnchor, constant: 30).isActive = true
        myTeamsView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        myTeamsView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        
        teamSearchBar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        teamSearchBar.widthAnchor.constraint(equalToConstant: 200).isActive = true
        teamSearchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        teamSearchBar.topAnchor.constraint(equalTo: myTeamsView.bottomAnchor, constant: 30).isActive = true
        
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        searchTableView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        searchTableView.topAnchor.constraint(equalTo: teamSearchBar.bottomAnchor, constant: 25).isActive = true
        searchTableView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        searchTableView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        
        createTeamButton.leftAnchor.constraint(equalTo: myTeamsLabel.rightAnchor).isActive = true
        createTeamButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        createTeamButton.centerYAnchor.constraint(equalTo: myTeamsLabel.centerYAnchor).isActive = true
        createTeamButton.heightAnchor.constraint(equalTo: myTeamsLabel.heightAnchor, multiplier: 0.5).isActive = true

    }


}
