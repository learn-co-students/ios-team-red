//
//  TeamsViewController.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import Firebase

class TeamsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, TeamsViewDelegate {
    
    var teamsView: TeamsView!

    let uid = FIRAuth.auth()?.currentUser?.uid
    var user: User? = nil
    
    var myTeams = [Team]()
    var publicTeams = [Team]()
    var filteredTeams = [Team]()
    var searchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        teamsView = TeamsView()
        self.view = teamsView
        
        teamsView.delegate = self
        
        setupSearchBar()
        
        navigationItem.setTitle(text: "teams")

        let profileButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_person"), style: .plain, target: self, action: #selector(onProfile(_:)))
        navigationItem.setRightBarButton(profileButton, animated: false)


        teamsView.myTeamsView.register(FitnessCell.self, forCellReuseIdentifier: "fitnessCell")
        teamsView.myTeamsView.delegate = self
        teamsView.myTeamsView.dataSource = self
        
        teamsView.searchTableView.register(FitnessCell.self, forCellReuseIdentifier: "fitnessCell")
        teamsView.searchTableView.delegate = self
        teamsView.searchTableView.dataSource = self
        
        DataStore.sharedInstance.observeAllTeams() {
            self.getAllTeams() {
                self.teamsView.myTeamsView.reloadData()
                self.teamsView.searchTableView.reloadData()
            }
        }
        
        self.hideKeyboardWhenTappedAround()
    }
    
    func segueCreateTeam() {
        let createTeamVC = CreateTeamVC()
        let navVC = NavigationController(rootViewController: createTeamVC)
        createTeamVC.modalPresentationStyle = .overFullScreen
        self.present(navVC, animated: true, completion: nil)
    }

    
    
// MARK: - Delegate and Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        if tableView == teamsView.myTeamsView {
            return myTeams.count
        }
        
        if tableView == teamsView.searchTableView {
            if searchActive {
                count = filteredTeams.count
            } else {
                count = publicTeams.count
            }
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = FitnessCell()

        if tableView == teamsView.myTeamsView {
            cell = teamsView.myTeamsView.dequeueReusableCell(withIdentifier: "fitnessCell") as! FitnessCell
            guard myTeams.count > 0 else {return cell} //TODO: disable user interactivity with table view. Maybe display a default image?
            cell.setLabels(forTeam: myTeams[indexPath.row])
        }
        
        if tableView == teamsView.searchTableView {
            if searchActive {
                cell = teamsView.searchTableView.dequeueReusableCell(withIdentifier: "fitnessCell") as! FitnessCell
                guard filteredTeams.count > 0 else {return cell}
                cell.setLabels(forTeam: filteredTeams[indexPath.row])
            } else {
                cell = teamsView.searchTableView.dequeueReusableCell(withIdentifier: "fitnessCell") as! FitnessCell
                guard publicTeams.count > 0 else {return cell} //TODO: disable user interactivity with table view. Maybe display a default image?
                cell.setLabels(forTeam: publicTeams[indexPath.row])
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teamDetailVC = TeamDetailVC()
        
        if tableView == teamsView.myTeamsView {
            teamDetailVC.setTeam(team: myTeams[indexPath.row])
            navigationController?.pushViewController(teamDetailVC, animated: true)
        } else if tableView == teamsView.searchTableView {
            if searchActive {
                teamDetailVC.setTeam(team: filteredTeams[indexPath.row])
              navigationController?.pushViewController(teamDetailVC, animated: true)
            } else {
                teamDetailVC.setTeam(team: publicTeams[indexPath.row])
              navigationController?.pushViewController(teamDetailVC, animated: true)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}

extension TeamsVC {
    
    // MARK: - calls to Firebase
//    func fetchData(completion: @escaping () -> Void) {
//        guard let uid = uid else {return}
//        FirebaseManager.fetchUser(withFirebaseUID: uid) { (user) in
//            self.user = user
//            self.getAllTeams(user: user) {
//                completion()
//            }
//        }
//    }
//    
//    private func getAllTeams(user: User, completion: @escaping () -> Void) { //Get all teams that exist in the data base, sort them alphabetically and then set them equal to the allTeams array available to TeamsVC
//        
//        FirebaseManager.fetchAllTeams { (teams) in
//            self.myTeams.removeAll()
//            self.publicTeams.removeAll()
//            self.filteredTeams.removeAll()
//            for team in teams {
//                if let teamID = team.id  {
//                    if user.teamIDs.contains(teamID) {
//                        self.myTeams.append(team)
//                    } else {
//                        self.publicTeams.append(team)
//                    }
//                }
//            }
//            self.myTeams = self.myTeams.sorted {$0.name.lowercased() < $1.name.lowercased()}
//            self.publicTeams = self.publicTeams.sorted {$0.name.lowercased() < $1.name.lowercased()}
//            self.filteredTeams = self.publicTeams
//            completion()
//        }
//    }
    
    func getAllTeams(completion: @escaping () -> Void) {
        self.myTeams.removeAll()
        self.publicTeams.removeAll()
        self.filteredTeams.removeAll()
        guard let uid = self.uid else {return}
        for team in DataStore.sharedInstance.allTeams {
            if team.userUIDs.contains(uid) {
                self.myTeams.append(team)
            } else {
                self.publicTeams.append(team)
            }
        }
        filteredTeams = publicTeams
        completion()
    }
    
}

extension TeamsVC: UISearchBarDelegate {//controls functionality for search bar
    
    
    
    //MARK: - search bar
    func setupSearchBar() {
        teamsView.teamSearchBar.delegate = self
        print("is user enabled?\(teamsView.teamSearchBar.isUserInteractionEnabled)")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true;
        print("Did begin editing")
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = true;
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
        
        filteredTeams = publicTeams.filter({ (team) -> Bool in
            let temp: String = team.name
            let range = temp.range(of: searchText, options: .caseInsensitive)
            return range != nil
        })
        
        if searchBar.text == nil || searchBar.text == "" {
            self.searchActive = false
        } else {
            self.searchActive = true
        }
        
        teamsView.searchTableView.reloadData()
    }

    func onProfile(_ sender: UIBarButtonItem) {
        let vc = ProfileUpdateVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}


















