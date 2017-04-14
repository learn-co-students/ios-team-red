//
//  ChallengesVC.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/12/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import Firebase

class ChallengesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let mainView = FitnessView()
    let uid = FIRAuth.auth()?.currentUser?.uid
    let myChallengesLabel = FitnessLabel()
    let publicChallengesLabel = FitnessLabel()
    
    let challengeSearchBar = UISearchBar()
    
    let myChallengesView = UITableView()
    let publicChallengesView = UITableView()
    
    var myChallenges = [Challenge]()
    var publicChallenges = [Challenge]()
    var filteredChallenges = [Challenge]()
    let createChallengeButton = FitnessButton()
    var searchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Challenges Baby"
        setupSubViews()
        setupSearchBar()
        
        myChallengesView.register(FitnessCell.self, forCellReuseIdentifier: "fitnessCell")
        myChallengesView.delegate = self
        myChallengesView.dataSource = self
        
        publicChallengesView.register(FitnessCell.self, forCellReuseIdentifier: "fitnessCell")
        publicChallengesView.delegate = self
        publicChallengesView.dataSource = self
        
        getMyChallenges()
        getPublicChallenges()
        
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
        var rows = 0
        if tableView == myChallengesView {
            rows = myChallenges.count
        } else if tableView == publicChallengesView {
            if searchActive {
                rows = filteredChallenges.count
            } else {
                rows = publicChallenges.count
            }
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = FitnessCell()
        
        if tableView == myChallengesView {
            cell = tableView.dequeueReusableCell(withIdentifier: "fitnessCell", for: indexPath) as! FitnessCell
            cell.setLabels(forChallenge: myChallenges[indexPath.row])
        } else if tableView == publicChallengesView {
            if searchActive {
                cell = tableView.dequeueReusableCell(withIdentifier: "fitnessCell", for: indexPath) as! FitnessCell
                cell.setLabels(forChallenge: filteredChallenges[indexPath.row])
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "fitnessCell", for: indexPath) as! FitnessCell
                cell.setLabels(forChallenge: publicChallenges[indexPath.row])
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == myChallengesView {
            let challengeDetailVC = ChallengeDetailVC()
            challengeDetailVC.setChallenge(challenge: myChallenges[indexPath.row])
            present(challengeDetailVC, animated: true, completion: nil)
            //navigationController?.pushViewController(challengeDetailVC, animated: true)
        } else if tableView == publicChallengesView {
            if searchActive {
                let challengeDetailVC = ChallengeDetailVC()
                challengeDetailVC.setChallenge(challenge: filteredChallenges[indexPath.row])
                present(challengeDetailVC, animated: true, completion: nil)
                //navigationController?.pushViewController(challengeDetailVC, animated: true)
            } else {
                let challengeDetailVC = ChallengeDetailVC()
                challengeDetailVC.setChallenge(challenge: publicChallenges[indexPath.row])
                present(challengeDetailVC, animated: true, completion: nil)
                //navigationController?.pushViewController(challengeDetailVC, animated: true)
            }
        }
    }

//MARK: Firebase calls
    func getMyChallenges() {
        guard let uid = self.uid else {return}
        FirebaseManager.fetchUser(withFirebaseUID: uid) { (user) in
            for challengeID in user.challengeIDs {
                FirebaseManager.fetchChallenge(withChallengeID: challengeID, completion: { (challenge) in
                    self.myChallenges.append(challenge)
                    self.myChallengesView.reloadData()
                })
            }
        }
    }
    
    func getPublicChallenges() {
        FirebaseManager.fetchPublicChallenges { (challenges) in
            self.publicChallenges = challenges
            self.publicChallengesView.reloadData()
        }
    }
}
