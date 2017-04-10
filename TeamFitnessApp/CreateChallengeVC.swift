//
//  CreateChallengeVC.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/10/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import Firebase

class CreateChallengeVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    var challengeIsPublic: Bool = false
    var searchActive: Bool = false
    var team: Team? = nil
    
    var myTeams = [Team]()
    var filteredTeams = [Team]()
    
    let titleLabel = TitleLabel()
    let teamSearchBar = UISearchBar()
    let publicButton = FitnessButton()
    let teamsTableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = FitnessView()
        setupViews()
        getMyTeams { 
            DispatchQueue.main.async {
                self.teamsTableView.reloadData()
            }
        }
        
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
        teamSearchBar.delegate = self
        print("public button frame: \(publicButton.frame)")
        
        view.addSubview(teamsTableView)
        teamsTableView.translatesAutoresizingMaskIntoConstraints = false
        teamsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        teamsTableView.topAnchor.constraint(equalTo: teamSearchBar.bottomAnchor, constant: 25).isActive = true
        teamsTableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        teamsTableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        teamsTableView.backgroundColor = UIColor.clear
        teamsTableView.isHidden = true
        teamsTableView.isUserInteractionEnabled = false
        teamsTableView.delegate = self
        teamsTableView.dataSource = self
        teamsTableView.register(FitnessCell.self, forCellReuseIdentifier: "fitnessCell")

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
//MARK: - Search bar delegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        print("Did begin editing")
        teamsTableView.isHidden = false
        teamsTableView.isUserInteractionEnabled = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        print("Did end editing")
        teamsTableView.isHidden = true
        teamsTableView.isUserInteractionEnabled = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        print("Clicked cacel button")
        teamsTableView.isHidden = true
        teamsTableView.isUserInteractionEnabled = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        print("Search button clicked")
        teamsTableView.isHidden = true
        teamsTableView.isUserInteractionEnabled = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("text did change")
        
        filteredTeams = myTeams.filter({ (team) -> Bool in
            let temp: String = team.name
            let range = temp.range(of: searchText, options: .caseInsensitive)
            return range != nil
        })
        
        if(filteredTeams.count == 0){
            searchActive = false;
        } else {
            searchActive = true;
        }
        teamsTableView.reloadData()
    }
//MARK: - Table view data source and delegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchActive {
            return filteredTeams.count
        } else {
            return myTeams.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fitnessCell", for: indexPath) as! FitnessCell
        
        if searchActive {
            cell.setLabels(forTeam: filteredTeams[indexPath.row])
        } else {
            cell.setLabels(forTeam: myTeams[indexPath.row])
        }
        return cell
    }
    
//MARK: - Firebase calls
    
    func getMyTeams(completion: @escaping () -> Void) {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {
            print("Could not get user, no user logged in")
            return
        }
        FirebaseManager.fetchUser(withFirebaseUID: uid) { (user) in
            let teamList = user.teamIDs
            for teamID in teamList {
                FirebaseManager.fetchTeam(withTeamID: teamID, completion: { (team) in
                    if team.captainID == uid {
                        self.myTeams.append(team)
                        completion()
                    }
                })
            }
        }
    }
}
