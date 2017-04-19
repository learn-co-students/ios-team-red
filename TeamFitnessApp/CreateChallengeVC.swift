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
            createChallengeView?.teamIndicator.text = team?.name
        }
    }
    var challenge: Challenge? = nil
    var user: User? = nil
    
    var myTeams = [Team]()
    var filteredTeams = [Team]()
    
    var createChallengeView: CreateChallengeView?
    
    //MARK: Subviews
    
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
        createChallengeView = CreateChallengeView(frame: view.frame)
        self.view = createChallengeView
        setupViews()
        getData()
        
    }
//MARK = setup view constraints
    func setupViews() {
        self.hideKeyboardWhenTappedAround()
        
        createChallengeView?.previousButton.addTarget(self, action: #selector(previousButtonPressed), for: .touchUpInside)
        createChallengeView?.publicButton.addTarget(self, action: #selector(publicButtonPressed), for: .touchUpInside)
        createChallengeView?.teamSearchBar.delegate = self
        createChallengeView?.teamsTableView.delegate = self
        createChallengeView?.teamsTableView.dataSource = self
        createChallengeView?.teamsTableView.register(FitnessCell.self, forCellReuseIdentifier: "fitnessCell")
        createChallengeView?.nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        
    }

// MARK: - button functions
    func publicButtonPressed() { //switch the 'public button' to on or off. If public button is on, turn off the search bar, and vice versa
        if challengeIsPublic {
            createChallengeView?.publicButton.reverseColors()
            createChallengeView?.teamSearchBar.isUserInteractionEnabled = true
            createChallengeView?.teamSearchBar.alpha = 1.0
            createChallengeView?.teamIndicator.text = "Find team to add new challenge:"
            self.challengeIsPublic = false
        } else {
            createChallengeView?.publicButton.backgroundColor = UIColor.foregroundOrange
            createChallengeView?.publicButton.setTitleColor(UIColor.backgroundBlack, for: .normal)
            createChallengeView?.teamSearchBar.isUserInteractionEnabled = false
            createChallengeView?.teamSearchBar.alpha = 0.5
            createChallengeView?.teamIndicator.text = "Public Challenge"
            self.challengeIsPublic = true
        }
    }
    
    func nextButtonPressed() {
        if viewState == .first { //if the user is on the first screen of the CreateChallengeView, store the values in the text/search/picker fields, and move to the next screen
            if !challengeIsPublic && team == nil {
                print("Must select a team to add the challenge to, or set challenge to public")
                //TODO: - if user has not entered all information needed to create challenge, indicate that to them
                return
            } else if createChallengeView?.challengeNameField.text == "" {
                createChallengeView?.challengeNameField.flashRed()
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
        challengeName = createChallengeView?.challengeNameField.text
        challengeGoal = createChallengeView?.goalPicker.goal
        challengeTeamID = team?.id
    }
    
    private func moveToSecondFields() {
        createChallengeView?.publicButton.hide()
        createChallengeView?.teamSearchBar.hide()
        createChallengeView?.goalPicker.hide()
        createChallengeView?.startDatePicker.show()
        createChallengeView?.endDatePicker.show()
        createChallengeView?.nextButton.setTitle("Submit", for: .normal)
        viewState = .second
    }
    
    private func storeSecondFields() {
        challengeStartDate = createChallengeView?.startDatePicker.date
        challengeEndDate = createChallengeView?.endDatePicker.date
    }
    
    func previousButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
//MARK: - Search bar delegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        print("Did begin editing")
        createChallengeView?.goalPicker.isHidden = true
        createChallengeView?.teamsTableView.isHidden = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false;
        createChallengeView?.goalPicker.isHidden = false
        print("Did end editing")
        createChallengeView?.teamsTableView.isHidden = true
        filteredTeams = myTeams
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        print("Clicked cacel button")
        createChallengeView?.goalPicker.isHidden = false
        createChallengeView?.teamsTableView.isHidden = true
        filteredTeams = myTeams
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false;
        print("Search button clicked")
        createChallengeView?.goalPicker.isHidden = false
        createChallengeView?.teamsTableView.isHidden = true
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
        createChallengeView?.teamsTableView.reloadData()
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
            createChallengeView?.teamIndicator.text = selectedTeam.name
            self.team = selectedTeam
        } else {
            let selectedTeam = myTeams[indexPath.row]
            self.team = selectedTeam
        }
        tableView.isHidden = true
        createChallengeView?.goalPicker.isHidden = false
    }
    
//MARK: - Firebase calls
    func getData() {
        getUser { (user) in
            self.getTeams(forUser: user, completion: {
                self.filteredTeams = self.myTeams
                DispatchQueue.main.async {
                    self.createChallengeView?.teamsTableView.reloadData()
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
