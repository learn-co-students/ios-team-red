//
//  TeamsVCExtension.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

extension TeamsVC { // Extension for setting up all views

//MARK: - subview setup
    func setupSubViews() {
        self.view = mainView
        setupTitle()
        setUpMyTeams()
        setUpTeamSearch()
        setupCreateTeamButton()
    }
    
    func setupTitle() {
        self.view.addSubview(myTeamsLabel)
        myTeamsLabel.setConstraints(toView: self.view, andViewController: self)
        myTeamsLabel.setText(toString: "My Teams")
    }
    
    func setUpMyTeams() {
        
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
        createTeamButton.centerYAnchor.constraint(equalTo: myTeamsLabel.centerYAnchor).isActive = true
        createTeamButton.heightAnchor.constraint(equalTo: myTeamsLabel.heightAnchor, multiplier: 0.5).isActive = true
        createTeamButton.setTitle("+", for: .normal)
        createTeamButton.changeFontSize(to: 18)
        createTeamButton.addTarget(self, action: #selector(segueCreateTeam), for: .touchUpInside)
    }
    
// MARK: - calls to Firebase
    func fetchData() {
        guard let uid = uid else {return}
        FirebaseManager.fetchUser(withFirebaseUID: uid) { (user) in
            self.user = user
            self.getAllTeams(user: user)
        }
    }
    
    private func getAllTeams(user: User) { //Get all teams that exist in the data base, sort them alphabetically and then set them equal to the allTeams array available to TeamsVC
        filteredTeams.removeAll()
        FirebaseManager.fetchAllTeams { (teams) in
            self.myTeams.removeAll()
            self.allTeams.removeAll()
            for team in teams {
                if let teamID = team.id  {
                    if user.teamIDs.contains(teamID) {
                        self.myTeams.append(team)
                    } else {
                        self.allTeams.append(team)
                    }
                }
            }
            self.myTeams = self.myTeams.sorted {$0.name.lowercased() < $1.name.lowercased()}
            self.allTeams = self.allTeams.sorted {$0.name.lowercased() < $1.name.lowercased()}
            self.filteredTeams = self.allTeams
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
                self.myTeamsView.reloadData()
            }
        }
    }

}

extension TeamsVC: UISearchBarDelegate {//controls functionality for search bar
    

//MARK: - search bar
    func setupSearchBar() {
        teamSearchBar.delegate = self
        print("is user enabled?\(teamSearchBar.isUserInteractionEnabled)")
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
