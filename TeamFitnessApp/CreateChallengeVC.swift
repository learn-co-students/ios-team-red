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
    var team: Team? = nil {
        didSet {
            teamIndicator.text = team?.name
        }
    }
    var challenge: Challenge? = nil
    var user: User? = nil
    
    var myTeams = [Team]()
    var filteredTeams = [Team]()
    
    //MARK: Subviews
    let titleLabel = TitleLabel()
    let challengeNameField = FitnessTextField()
    let teamIndicator = FitnessLabel()
    let teamSearchBar = UISearchBar()
    let publicButton = PublicButton()
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
//MARK = setup view constraints
    func setupViews() {
        self.view.addSubview(titleLabel)
        titleLabel.setConstraints(toView: self.view, andViewController: self)
        titleLabel.setText(toString: "New Challenge")
        
        self.view.addSubview(challengeNameField)
        challengeNameField.setConstraints(toSuperview: self.view, belowView: titleLabel)
        challengeNameField.setPlaceholder(toText: "Name challenge")
        
        self.view.addSubview(teamIndicator)
        teamIndicator.setConstraints(toSuperView: self.view, belowView: challengeNameField)
        if teamIndicator.text == nil {
            teamIndicator.set(text: "Find team to add new challenge:")
        }
        teamIndicator.reverseColors()
        
        self.view.addSubview(teamSearchBar)
        teamSearchBar.constrainVertically(belowView: teamIndicator, widthMultiplier: 0.5, heightMultiplier: 0.05)
        teamSearchBar.placeholder = "Find team"
        teamSearchBar.searchBarStyle = .minimal
        
        self.view.addSubview(publicButton)
        publicButton.setConstraints(nextToView: teamSearchBar)
        publicButton.reverseColors()
        publicButton.setTitle("Public?", for: .normal)
        publicButton.addTarget(self, action: #selector(publicButtonPressed), for: .touchUpInside)
        teamSearchBar.isUserInteractionEnabled = true
        teamSearchBar.alpha = 1.0
        teamSearchBar.delegate = self
        print("public button frame: \(publicButton.frame)")
        
        view.addSubview(teamsTableView)
        teamsTableView.constrainVertically(belowView: teamSearchBar, widthMultiplier: 0.8, heightMultiplier: 0.25)
        teamsTableView.backgroundColor = UIColor.clear
        teamsTableView.alpha = 0
        teamsTableView.delegate = self
        teamsTableView.dataSource = self
        teamsTableView.register(FitnessCell.self, forCellReuseIdentifier: "fitnessCell")

        view.addSubview(goalPicker)
        goalPicker.constrainVertically(belowView: teamSearchBar, widthMultiplier: 0.8, heightMultiplier: 0.5)
        self.view.bringSubview(toFront: goalPicker.stepper)
        
        view.addSubview(startDatePicker)
        startDatePicker.setConstraints(toSuperView: self.view, belowView: teamSearchBar)
        startDatePicker.setTitle(toString: "Challenge Start Date:")
        startDatePicker.alpha = 0
        
        view.addSubview(endDatePicker)
        endDatePicker.setConstraints(toSuperView: self.view, belowView: startDatePicker)
        endDatePicker.setTitle(toString: "Challenge End Date:")
        endDatePicker.alpha = 0
        
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
        if viewState == .first { //if the user is on the first screen of the CreateChallengeView, store the values in the text/search/picker fields, and move to the next screen
            if !challengeIsPublic && team == nil {
                print("Must select a team to add the challenge to, or set challenge to public")
                //TODO: - if user has not entered all information needed to create challenge, indicate that to them
                return
            } else if challengeNameField.text == "" {
                challengeNameField.flashRed()
                return
            }
            storeFirstFields()
            moveToSecondFields()
            
        } else if viewState == .second { //if the user is on the second screen, store the new values for the start/end datePickerViews, and then create a new challenge in the Firebase database
            print("save new challenge")
            storeSecondFields()
            
            if let challengeName = challengeName, let challengeStartDate = challengeStartDate, let challengeEndDate = challengeEndDate, let challengeGoal = challengeGoal, let challengeCreatorID = challengeCreatorID {
                let newChallenge = Challenge(name: challengeName, startDate: challengeStartDate, endDate: challengeEndDate, goal: challengeGoal, creatorID: challengeCreatorID, userUIDs: challengeUserIDs as? [String] ?? [], isPublic: challengeIsPublic, team: challengeTeamID)

                FirebaseManager.addNew(challenge: newChallenge, completion: { (challengeID) in
                    guard let userUID = user?.uid else {return}

                    if challengeIsPublic {//if challenge is public, add challenge to the challenges property of the user in Firebase. The userID will already have been stored in the users field of the public challenge
                        FirebaseManager.add(childID: challengeID, toParentId: userUID, parentDataType: .users, childDataType: .challenges, completion: {
                        })
                    } else { //if the challenge is not public, add the challenge to the challenges property of the user and team in Firebase. The user and team IDs have already been stored in the challenge directory in Firebase
                        guard let userUID = user?.uid else {return}
                        FirebaseManager.add(childID: challengeID, toParentId: userUID, parentDataType: .users, childDataType: .challenges, completion: {
                        })
                        guard let teamID = team?.id else {return}
                        FirebaseManager.add(childID: challengeID, toParentId: teamID, parentDataType: .teams, childDataType: .challenges, completion: {
                        })
                    }
                })
                self.dismiss(animated: true, completion: nil)
            } else {
                //TODO: - if user has not entered all information needed to create challenge, indicate that to them
            }
        }
    }
    
    private func storeFirstFields() {
        challengeName = challengeNameField.text
        challengeGoal = goalPicker.goal
        challengeTeamID = team?.id
    }
    
    private func moveToSecondFields() {
        publicButton.hide()
        teamSearchBar.hide()
        goalPicker.hide()
        startDatePicker.show()
        endDatePicker.show()
        nextButton.setTitle("Submit", for: .normal)
        viewState = .second
    }
    
    private func storeSecondFields() {
        challengeStartDate = startDatePicker.date
        challengeEndDate = endDatePicker.date
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
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        goalPicker.isHidden = false
        print("Did end editing")
        teamsTableView.isHidden = true
        filteredTeams = myTeams
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        print("Clicked cacel button")
        goalPicker.isHidden = false
        teamsTableView.isHidden = true
        filteredTeams = myTeams
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        print("Search button clicked")
        goalPicker.isHidden = false
        teamsTableView.isHidden = true
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
