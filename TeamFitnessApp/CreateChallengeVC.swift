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
    var challenge: Challenge? = nil
    var user: User? = nil
    
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
    let goalPicker = GoalPickerView()
    let nextButton = FitnessButton()
    let previousButton = FitnessButton()
    var viewState: ViewState = .first
    
    //MARK: - properties being stored to create challenge instance:
    var challengeName: String? = nil
    var challengeStartDate: Date? = nil
    var challengeEndDate: Date? = nil
    var challengeGoal: Goal? = nil
    let challengeCreatorID = FIRAuth.auth()?.currentUser?.uid
    var challengeUserIDs: [String?] = [(FIRAuth.auth()?.currentUser?.uid)]
    var challengeTeamID: String?
    
    enum ViewState {
        case first, second
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = FitnessView()
        
        setupViews()
        getData()
        
    }
    
    func setupViews() {
        self.view.addSubview(titleLabel)
        titleLabel.setConstraints(toView: self.view, andViewController: self)
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

        
        view.addSubview(goalPicker)
        goalPicker.translatesAutoresizingMaskIntoConstraints = false
        goalPicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        goalPicker.topAnchor.constraint(equalTo: teamSearchBar.bottomAnchor, constant: 25).isActive = true
        goalPicker.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
        goalPicker.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        self.view.bringSubview(toFront: goalPicker.stepper)
        
        view.addSubview(startDatePicker)
        startDatePicker.translatesAutoresizingMaskIntoConstraints = false
        startDatePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startDatePicker.topAnchor.constraint(equalTo: teamSearchBar.bottomAnchor, constant: 25).isActive = true
        startDatePicker.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.25).isActive = true
        startDatePicker.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        startDatePicker.setTitle(toString: "Challenge Start Date:")
        startDatePicker.isHidden = true
        
        view.addSubview(endDatePicker)
        endDatePicker.translatesAutoresizingMaskIntoConstraints = false
        endDatePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        endDatePicker.topAnchor.constraint(equalTo: startDatePicker.bottomAnchor, constant: 50).isActive = true
        endDatePicker.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        endDatePicker.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        endDatePicker.setTitle(toString: "Challenge End Date:")
        endDatePicker.isHidden = true
        
        view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.leftAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.topAnchor.constraint(equalTo: endDatePicker.bottomAnchor, constant: 10).isActive = true
        nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
        nextButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        nextButton.setTitle("➡", for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        
        view.addSubview(previousButton)
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        previousButton.rightAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        previousButton.topAnchor.constraint(equalTo: endDatePicker.bottomAnchor, constant: 10).isActive = true
        previousButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25).isActive = true
        previousButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        previousButton.addTarget(self, action: #selector(previousButtonPressed), for: .touchUpInside)
        previousButton.setTitle("Cancel", for: .normal)
    }

// MARK: - button functions
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
    
    func nextButtonPressed() {
        if viewState == .first {
            if !challengeIsPublic && team == nil {
                print("Must select a team to add the challenge to, or set challenge to public")
                return
            }
            publicButton.isHidden = true
            teamSearchBar.isHidden = true
            goalPicker.isHidden = true
            startDatePicker.isHidden = false
            endDatePicker.isHidden = false
            nextButton.setTitle("Submit", for: .normal)
            viewState = .second
            
            challengeName = challengeNameField.text
            challengeGoal = goalPicker.goal
            challengeTeamID = team?.id
            
        } else if viewState == .second {
            print("save new challenge")
            challengeStartDate = startDatePicker.date
            challengeEndDate = endDatePicker.date
            let challengeTeamID = self.challengeTeamID ?? "No team"
            if let challengeName = challengeName, let challengeStartDate = challengeStartDate, let challengeEndDate = challengeEndDate, let challengeGoal = challengeGoal, let challengeCreatorID = challengeCreatorID {
                challenge = Challenge(name: challengeName,startDate: challengeStartDate, endDate: challengeEndDate, goal: challengeGoal, creatorID: challengeCreatorID, userUIDs: challengeUserIDs as? [String] ?? [], isPublic: challengeIsPublic, team: challengeTeamID)
                guard let challenge = challenge else {return}
                FirebaseManager.addNew(challenge: challenge, isPublic: challenge.isPublic, completion: { (challengeID) in
                    if challengeIsPublic {
                        print("Challenged saved to public challenges")
                    } else {
                        guard var user = user else {return}
                        user.challengeIDs.append(challengeID)
                        FirebaseManager.save(user: user)
                        guard var team = team else {return}
                        team.challengeIDs.append(challengeID)
                        FirebaseManager.save(team: team)
                    }
                })
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func previousButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
//MARK: - Search bar delegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        print("Did begin editing")
        self.view.bringSubview(toFront: teamsTableView)
        goalPicker.isHidden = true
        teamsTableView.isHidden = false
        teamsTableView.isUserInteractionEnabled = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        goalPicker.isHidden = false
        print("Did end editing")
        teamsTableView.isHidden = true
        teamsTableView.isUserInteractionEnabled = false
        filteredTeams = myTeams
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        print("Clicked cacel button")
        goalPicker.isHidden = false
        teamsTableView.isHidden = true
        teamsTableView.isUserInteractionEnabled = false
        filteredTeams = myTeams
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        print("Search button clicked")
        goalPicker.isHidden = false
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
        goalPicker.isHidden = false
    }
    
//MARK: - Firebase calls
    func getData() {
        getUser { (user) in
            self.getTeams(forUser: user, completion: {
                self.filteredTeams = self.myTeams
                DispatchQueue.main.async {
                    self.teamsTableView.reloadData()
                }
            })
        }
    }
    
    func getUser(completion: @escaping (User) -> Void) {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {return}
        FirebaseManager.fetchUser(withFirebaseUID: uid) { (user) in
            self.user = user
            completion(user)
        }
    }
    
    private func getTeams(forUser user: User, completion: @escaping () -> Void) {
        myTeams.removeAll()
        filteredTeams.removeAll()
        let teamList = user.teamIDs
        for teamID in teamList {
            FirebaseManager.fetchTeam(withTeamID: teamID, completion: { (team) in
                if team.captainID == user.uid {
                    self.myTeams.append(team)
                    completion()
                }
            })
        }
    }
    
    
    
    
}
