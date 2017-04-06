//
//  TeamsViewController.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class TeamsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let screenBounds = UIScreen.main.bounds
    
    let mainView = FitnessView()
    let titleLabel = FitnessLabel()
    let myTeamsLabel = FitnessLabel()
    let teamSearchBar = UISearchBar()
    
    let myTeamsView = UITableView()
    let searchTableView = UITableView()
    
    var myTeams = [Team]()
    var allTeams = [Team]()
    var filteredTeams = [Team]()
    var searchActive: Bool = false {
        didSet {
            print(searchActive)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        setupSearchBar()
        
        myTeamsView.register(TeamsCell.self, forCellReuseIdentifier: "teamsCell")
        myTeamsView.delegate = self
        myTeamsView.dataSource = self
        
        searchTableView.register(TeamsCell.self, forCellReuseIdentifier: "teamsCell")
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        let user = generateTestUser() //test function
        getTeams(forUser: user)
        loadAllTeams()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 0
        if tableView == self.myTeamsView{
            return myTeams.count
        }
        
        if tableView == self.searchTableView  {
            if searchActive {
                count = filteredTeams.count
            } else {
            print(allTeams.count)
                count = allTeams.count
            }
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = TeamsCell()

        if tableView == self.myTeamsView {
            cell = myTeamsView.dequeueReusableCell(withIdentifier: "teamsCell") as! TeamsCell//TODO create a default intialized cell
            cell.team = myTeams[indexPath.row]
        }
        
        if tableView == self.searchTableView {
            if searchActive {
                cell = searchTableView.dequeueReusableCell(withIdentifier: "teamsCell") as! TeamsCell
                cell.team = filteredTeams[indexPath.row]
            } else {
                cell = searchTableView.dequeueReusableCell(withIdentifier: "teamsCell") as! TeamsCell
                cell.team = allTeams[indexPath.row]
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teamDetailVC = TeamDetailVC()
        
        if tableView == self.myTeamsView {
            teamDetailVC.setTeam(team: myTeams[indexPath.row])
            present(teamDetailVC, animated: true, completion: nil)
        } else if tableView == self.searchTableView {
            if searchActive {
                teamDetailVC.setTeam(team: filteredTeams[indexPath.row])
                present(teamDetailVC, animated: true, completion: nil)
            } else {
                teamDetailVC.setTeam(team: allTeams[indexPath.row])
                present(teamDetailVC, animated: true, completion: nil)
            }
        }
    }
    
    func getTeams(forUser user: User) {//gets all of the teams for the user from Firebase, and sets them to the teams property of the VC
        let teamList = user.teamIDs
        for teamID in teamList {
            FirebaseManager.fetchTeam(withTeamID: teamID, completion: { (team) in
                self.myTeams.append(team)
                DispatchQueue.main.async {
                    self.myTeamsView.reloadData()
                }
            })
        }
    }
    
    func generateTestUser() -> User {//test function
        let user = User(name: "", sex: "", height: 123, weight: 123, teamIDs: ["team1UID1234", "team2UID5678"], challengeIDs: [], imageURL: "", uid: "", email: "")
        return user
    }
    
    
}

















