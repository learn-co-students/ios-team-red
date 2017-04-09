//
//  TeamsVCExtension.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

extension TeamsVC { // Extension for setting up all views
    
    func setupSubViews() {
        self.view = mainView
        setupTitle()
        setUpMyTeams()
        setUpTeamSearch()
        setupCreateTeamButton()
    }
    
    func setupTitle() {
        self.view.addSubview(titleLabel)
        titleLabel.setConstraints(toView: self.view)
        titleLabel.setText(toString: "Teams")
    }
    
    func setUpMyTeams() {
        view.addSubview(myTeamsLabel)
        myTeamsLabel.translatesAutoresizingMaskIntoConstraints = false
        myTeamsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myTeamsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        myTeamsLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        myTeamsLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        myTeamsLabel.textAlignment = .center
        myTeamsLabel.changeFontSize(to: 20)
        myTeamsLabel.reverseColors()
        myTeamsLabel.text = "My Teams:"
        
        view.addSubview(myTeamsView)
        myTeamsView.translatesAutoresizingMaskIntoConstraints = false
        myTeamsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myTeamsView.topAnchor.constraint(equalTo: myTeamsLabel.bottomAnchor).isActive = true
        myTeamsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        myTeamsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        myTeamsView.backgroundColor = UIColor.clear
    }
    
    func setUpTeamSearch() {
        view.addSubview(teamSearchBar)
        teamSearchBar.translatesAutoresizingMaskIntoConstraints = false
        teamSearchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        teamSearchBar.topAnchor.constraint(equalTo: myTeamsView.bottomAnchor, constant: 20).isActive = true
        teamSearchBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        teamSearchBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        teamSearchBar.placeholder = "Find Teams by Name:"
        teamSearchBar.backgroundColor = UIColor.foregroundOrange
        
        view.addSubview(searchTableView)
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        searchTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchTableView.topAnchor.constraint(equalTo: teamSearchBar.bottomAnchor, constant: 25).isActive = true
        searchTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        searchTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        searchTableView.backgroundColor = UIColor.clear
    }
    
    func setupCreateTeamButton() {
        view.addSubview(createTeamButton)
        createTeamButton.translatesAutoresizingMaskIntoConstraints = false
        createTeamButton.leftAnchor.constraint(equalTo: myTeamsLabel.rightAnchor).isActive = true
        createTeamButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        createTeamButton.topAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        createTeamButton.bottomAnchor.constraint(equalTo: myTeamsLabel.topAnchor).isActive = true
        createTeamButton.setTitle("+", for: .normal)
        createTeamButton.changeFontSize(to: 18)
        createTeamButton.addTarget(self, action: #selector(segueCreateTeam), for: .touchUpInside)
    }
}

extension TeamsVC: UISearchBarDelegate {//controls functionality for search bar
    
    
    func setupSearchBar() {
        teamSearchBar.delegate = self
        print("is user enabled?\(teamSearchBar.isUserInteractionEnabled)")
    }
    
    func loadAllTeams() {
        FirebaseManager.fetchAllTeams { (teams) in
            self.allTeams = teams
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        print("Did begin editing")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        print("Did end editing")
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        print("Clicked cacel button")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        print("Search button clicked")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("text did change")
        
        filteredTeams = allTeams.filter({ (team) -> Bool in
            let temp: String = team.name
            let range = temp.range(of: searchText, options: .caseInsensitive)
            return range != nil
        })
        
        if(filteredTeams.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        searchTableView.reloadData()
    }
}
