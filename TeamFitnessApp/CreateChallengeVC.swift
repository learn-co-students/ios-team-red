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
    let challengeNameField = UITextField()
    let teamIndicator = FitnessLabel()
    let teamSearchBar = UISearchBar()
    let publicButton = FitnessButton()
    let teamsTableView = UITableView()
    let startDatePicker = FitnessDatePickerView()
    let endDatePicker = FitnessDatePickerView()
    let nextButton = FitnessButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = FitnessView()
        setupViews()
        getMyTeams {
            self.filteredTeams = self.myTeams
            DispatchQueue.main.async {
                self.teamsTableView.reloadData()
            }
        }
        
    }
    
    func setupViews() {
        self.view.addSubview(titleLabel)
        titleLabel.setConstraints(toView: self.view)
        titleLabel.setText(toString: "New Challenge")
        
        self.view.addSubview(challengeNameField)
        challengeNameField.translatesAutoresizingMaskIntoConstraints = false
        challengeNameField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        challengeNameField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        challengeNameField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        challengeNameField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        challengeNameField.placeholder = "Name challenge"
        challengeNameField.backgroundColor = UIColor.foregroundOrange
        challengeNameField.textColor = UIColor.backgroundBlack
        challengeNameField.layer.cornerRadius = 5
        
        
        self.view.addSubview(teamIndicator)
        teamIndicator.translatesAutoresizingMaskIntoConstraints = false
        teamIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        teamIndicator.topAnchor.constraint(equalTo: challengeNameField.bottomAnchor).isActive = true
        teamIndicator.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        teamIndicator.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        teamIndicator.reverseColors()
        teamIndicator.text = "Find team to add new challenge:"
        
        self.view.addSubview(teamSearchBar)
        teamSearchBar.translatesAutoresizingMaskIntoConstraints = false
        teamSearchBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        teamSearchBar.topAnchor.constraint(equalTo: teamIndicator.bottomAnchor).isActive = true
        teamSearchBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        teamSearchBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        teamSearchBar.placeholder = "Find team"
        teamSearchBar.backgroundColor = UIColor.foregroundOrange
        
        self.view.addSubview(publicButton)
        publicButton.translatesAutoresizingMaskIntoConstraints = false
        publicButton.topAnchor.constraint(equalTo: teamSearchBar.topAnchor).isActive = true
        publicButton.rightAnchor.constraint(equalTo: teamSearchBar.leftAnchor, constant: -10).isActive = true
        publicButton.heightAnchor.constraint(equalTo: teamSearchBar.heightAnchor).isActive = true
        publicButton.widthAnchor.constraint(equalTo: publicButton.heightAnchor, multiplier: 2.0).isActive = true
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
        
        view.addSubview(startDatePicker)
        startDatePicker.translatesAutoresizingMaskIntoConstraints = false
        startDatePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startDatePicker.topAnchor.constraint(equalTo: teamSearchBar.bottomAnchor, constant: 50).isActive = true
        startDatePicker.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
        startDatePicker.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        startDatePicker.setTitle(toString: "Challenge Start Date:")
        
        view.addSubview(endDatePicker)
        endDatePicker.translatesAutoresizingMaskIntoConstraints = false
        endDatePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        endDatePicker.topAnchor.constraint(equalTo: startDatePicker.bottomAnchor, constant: 50).isActive = true
        endDatePicker.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        endDatePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        endDatePicker.setTitle(toString: "Challenge End Date:")
        
        view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.topAnchor.constraint(equalTo: endDatePicker.bottomAnchor, constant: 10).isActive = true
        nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
        nextButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        nextButton.setTitle("➡", for: .normal)
    }
    
    func publicButtonPressed() { //switch the 'public button' to on or off. If public button is on, turn off the search bar, and vice versa
        if challengeIsPublic {
            publicButton.reverseColors()
            teamSearchBar.isUserInteractionEnabled = true
            teamSearchBar.alpha = 1.0
            teamIndicator.text = "Find team to add new challenge:"
            challengeIsPublic = false
        } else {
            publicButton.backgroundColor = UIColor.foregroundOrange
            publicButton.setTitleColor(UIColor.backgroundBlack, for: .normal)
            teamSearchBar.isUserInteractionEnabled = false
            teamSearchBar.alpha = 0.5
            teamIndicator.text = "Public Challenge"
            challengeIsPublic = true
        }
    }
//MARK: - Search bar delegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        print("Did begin editing")
        self.view.bringSubview(toFront: teamsTableView)
        startDatePicker.isHidden = true
        teamsTableView.isHidden = false
        teamsTableView.isUserInteractionEnabled = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        startDatePicker.isHidden = false
        print("Did end editing")
        teamsTableView.isHidden = true
        teamsTableView.isUserInteractionEnabled = false
        filteredTeams = myTeams
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        print("Clicked cacel button")
        startDatePicker.isHidden = false
        teamsTableView.isHidden = true
        teamsTableView.isUserInteractionEnabled = false
        filteredTeams = myTeams
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        print("Search button clicked")
        startDatePicker.isHidden = false
        teamsTableView.isHidden = true
        teamsTableView.isUserInteractionEnabled = false
        filteredTeams = myTeams
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searchActive {
            let selectedTeam = filteredTeams[indexPath.row]
            teamIndicator.text = selectedTeam.name
            self.team = selectedTeam
        } else {
            let selectedTeam = myTeams[indexPath.row]
            teamIndicator.text = selectedTeam.name
            self.team = selectedTeam
        }
        tableView.isHidden = true
        startDatePicker.isHidden = false
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
