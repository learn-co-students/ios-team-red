//
//  TeamsViewController.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import Firebase

class TeamsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let mainView = FitnessView()
    let uid = FIRAuth.auth()?.currentUser?.uid
    var user: User? = nil
    let myTeamsLabel = TitleLabel()
    let createTeamButton = FitnessButton()
    let teamSearchBar = UISearchBar()
    
    let myTeamsView = UITableView()
    let searchTableView = UITableView()
    
    var myTeams = [Team]()
    var publicTeams = [Team]()
    var filteredTeams = [Team]()
    var searchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      let titleLabel = FitnessLabel(frame: CGRect(x:0, y:0, width: 150, height: 45))
      titleLabel.set(text: "fitness baby")
      titleLabel.textColor = UIColor.whitewash
      navigationItem.titleView = titleLabel
        setupSubViews()
        setupSearchBar()
        
        myTeamsView.register(FitnessCell.self, forCellReuseIdentifier: "fitnessCell")
        myTeamsView.delegate = self
        myTeamsView.dataSource = self
        
        searchTableView.register(FitnessCell.self, forCellReuseIdentifier: "fitnessCell")
        searchTableView.delegate = self
        searchTableView.dataSource = self
        
        fetchData {
            DispatchQueue.main.async {
                self.searchTableView.reloadData()
                self.myTeamsView.reloadData()
            }
        }
    }
    
// MARK: - Delegate and Data Source
    
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
                count = publicTeams.count
            }
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = FitnessCell()

        if tableView == self.myTeamsView {
            cell = myTeamsView.dequeueReusableCell(withIdentifier: "fitnessCell") as! FitnessCell//TODO create a default intialized cell
            cell.setLabels(forTeam: myTeams[indexPath.row])
        }
        
        if tableView == self.searchTableView {
            if searchActive {
                cell = searchTableView.dequeueReusableCell(withIdentifier: "fitnessCell") as! FitnessCell
                cell.setLabels(forTeam: filteredTeams[indexPath.row])
            } else {
                cell = searchTableView.dequeueReusableCell(withIdentifier: "fitnessCell") as! FitnessCell
                
                cell.setLabels(forTeam: publicTeams[indexPath.row])
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teamDetailVC = TeamDetailVC()
        
        if tableView == self.myTeamsView {
            teamDetailVC.setTeam(team: myTeams[indexPath.row])
            navigationController?.pushViewController(teamDetailVC, animated: true)
        } else if tableView == self.searchTableView {
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
    
    func segueCreateTeam() {
        let createTeamVC = CreateTeamVC()
        navigationController?.pushViewController(createTeamVC, animated: true)
    }

}

















