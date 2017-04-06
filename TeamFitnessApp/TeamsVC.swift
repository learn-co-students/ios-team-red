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
    let myTeamsView = TeamsTableView()
    let teamSearchBar = UISearchBar()
    let teamSearchView = UITableView()
    var myTeams = [Team]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        myTeamsView.register(TeamsCell.self, forCellReuseIdentifier: "teamsCell")
        myTeamsView.delegate = self
        myTeamsView.dataSource = self
        let user = generateTestUser()
        getTeams(forUser: user)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return myTeams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTeamsView.dequeueReusableCell(withIdentifier: "teamsCell") as! TeamsCell
        cell.team = myTeams[indexPath.row]
        return cell
    }
    
    func getTeams(forUser user: User) {
        print("Getting teams: \(user.teamIDs)")
        let teamList = user.teamIDs
        for teamID in teamList {
            FirebaseManager.fetchTeam(withTeamID: teamID, completion: { (team) in
                print("Fetched team: \(team.id)")
                self.myTeams.append(team)
                DispatchQueue.main.async {
                    print(self.myTeams)
                    self.myTeamsView.reloadData()
                }
            })
        }
        
    }
    
    func generateTestUser() -> User {
        let user = User(name: "", sex: "", height: 123, weight: 123, teamIDs: ["team1UID1234", "team2UID5678"], challengeIDs: [], imageURL: "", uid: "", email: "")
        print("User teams: \(user.teamIDs)")
        return user
    }
}

















