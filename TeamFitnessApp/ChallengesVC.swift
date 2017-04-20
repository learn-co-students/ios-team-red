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

    var challengeView: ChallengesView!
    let uid = FIRAuth.auth()?.currentUser?.uid
    var myChallenges = [Challenge]()
    var publicChallenges = [Challenge]()
    var filteredChallenges = [Challenge]()

    var searchActive: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setTitle(text: "group challenges")

        let profileButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_person"), style: .plain, target: self, action: #selector(onProfile(_:)))
        navigationItem.setRightBarButton(profileButton, animated: false)


        challengeView = ChallengesView(frame: view.frame)
        self.view = challengeView
        challengeView.challengeSearchBar.delegate = self
        
        challengeView.myChallengesView.register(FitnessCell.self, forCellReuseIdentifier: "fitnessCell")
        challengeView.myChallengesView.delegate = self
        challengeView.myChallengesView.dataSource = self
        
        challengeView.publicChallengesView.register(FitnessCell.self, forCellReuseIdentifier: "fitnessCell")
        challengeView.publicChallengesView.delegate = self
        challengeView.publicChallengesView.dataSource = self

        challengeView.createChallengeButton.addTarget(self, action: #selector(segueCreateChallenge), for: .touchUpInside)

        setupSearchBar()
//        getMyChallenges()
//        getPublicChallenges() {
//            DispatchQueue.main.async {
//                self.challengeView.publicChallengesView.reloadData()
//            }
//        }
        getAllChallenges {
            self.challengeView.publicChallengesView.reloadData()
            self.challengeView.myChallengesView.reloadData()
        }
        
        self.hideKeyboardWhenTappedAround()
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        if tableView == challengeView.myChallengesView {
            rows = myChallenges.count
        } else if tableView == challengeView.publicChallengesView {
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
        
        if tableView == challengeView.myChallengesView {
            cell = tableView.dequeueReusableCell(withIdentifier: "fitnessCell", for: indexPath) as! FitnessCell
            cell.setLabels(forChallenge: myChallenges[indexPath.row])
        } else if tableView == challengeView.publicChallengesView {

            if searchActive {
                cell = challengeView.publicChallengesView.dequeueReusableCell(withIdentifier: "fitnessCell", for: indexPath) as! FitnessCell
                cell.setLabels(forChallenge: filteredChallenges[indexPath.row])
            } else {
                cell = challengeView.publicChallengesView.dequeueReusableCell(withIdentifier: "fitnessCell", for: indexPath) as! FitnessCell
                cell.setLabels(forChallenge: publicChallenges[indexPath.row])
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == challengeView.myChallengesView {
            let challengeDetailVC = ChallengeDetailVC()
            challengeDetailVC.setChallenge(challenge: myChallenges[indexPath.row])
//            present(challengeDetailVC, animated: true, completion: nil)
            navigationController?.pushViewController(challengeDetailVC, animated: true)
        } else if tableView == challengeView.publicChallengesView {
            if searchActive {
                let challengeDetailVC = ChallengeDetailVC()
                challengeDetailVC.setChallenge(challenge: filteredChallenges[indexPath.row])
//                present(challengeDetailVC, animated: true, completion: nil)
                navigationController?.pushViewController(challengeDetailVC, animated: true)
            } else {
                let challengeDetailVC = ChallengeDetailVC()
                challengeDetailVC.setChallenge(challenge: publicChallenges[indexPath.row])
//                present(challengeDetailVC, animated: true, completion: nil)
                navigationController?.pushViewController(challengeDetailVC, animated: true)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }

  func segueCreateChallenge() {
    let createChallengeVC = CreateChallengeVC()
    let navVC = NavigationController(rootViewController: createChallengeVC)
    createChallengeVC.challengeIsPublic = true
    createChallengeVC.modalPresentationStyle = .fullScreen
    self.present(navVC, animated: true, completion: nil)
  }

//MARK: Firebase calls
    func getMyChallenges() {
        guard let uid = self.uid else {return}
        FirebaseManager.fetchUser(withFirebaseUID: uid) { (user) in
            self.myChallenges.removeAll()
            for challengeID in user.challengeIDs {
                FirebaseManager.fetchChallengeOnce(withChallengeID: challengeID, completion: { (challenge) in
                    self.myChallenges.append(challenge)
                    DispatchQueue.main.async {
                        self.challengeView.myChallengesView.reloadData()
                    }
                })
            }
        }
    }
    
    func getPublicChallenges(completion: @escaping () -> Void) {
        FirebaseManager.fetchAllChallenges { (challenges) in
            self.publicChallenges.removeAll()
            self.publicChallenges = challenges.filter{$0.isPublic}
            self.filteredChallenges = self.publicChallenges
            completion()
        }
    }
    
    func getAllChallenges(completion: @escaping () -> Void) {
        guard let uid = self.uid else {return}
        FirebaseManager.fetchUser(withFirebaseUID: uid) { (user) in
            FirebaseManager.fetchAllChallengesOnce { (challenges) in
                self.publicChallenges.removeAll()
                self.myChallenges.removeAll()
                self.filteredChallenges.removeAll()
                self.publicChallenges = challenges.filter{$0.isPublic}
                self.filteredChallenges = self.publicChallenges
                self.myChallenges = challenges.filter({ (challenge) -> Bool in
                    if let challengeID = challenge.id {
                        return user.challengeIDs.contains(challengeID)
                    } else {
                        return false
                    }
                })
                completion()
            }
        }
        
    }
}

extension ChallengesVC: UISearchBarDelegate {//controls functionality for search bar

    //MARK: - search bar
  func setupSearchBar() {
    challengeView.challengeSearchBar.delegate = self
  }

  func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
    searchActive = false;
  }

  func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
    searchActive = false;
  }

  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchActive = false;
  }

  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    searchActive = false;

  }

  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {


    filteredChallenges = publicChallenges.filter({ (challenge) -> Bool in
      let temp: String = challenge.name
      let range = temp.range(of: searchText, options: .caseInsensitive)
      return range != nil
    })
    if challengeView.challengeSearchBar.text == nil || challengeView.challengeSearchBar.text == "" {
      self.searchActive = false
    } else {
      self.searchActive = true
    }

    challengeView.publicChallengesView.reloadData()
  }

    func onProfile(_ sender: UIBarButtonItem) {
        let vc = ProfileUpdateVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

