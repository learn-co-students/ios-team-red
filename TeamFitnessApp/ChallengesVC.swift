//
//  ChallengesVC.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/12/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.


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

        challengeView.myChallengesView.register(FitnessCell.self, forCellReuseIdentifier: "fitnessCell")
        challengeView.myChallengesView.delegate = self
        challengeView.myChallengesView.dataSource = self
        
        challengeView.createChallengeButton.addTarget(self, action: #selector(segueCreateChallenge), for: .touchUpInside)


        challengeView.createChallengeButton.addTarget(self, action: #selector(segueCreateChallenge), for: .touchUpInside)

        challengeView.findChallengeButton.addTarget(self, action: #selector(segueFindChallenge), for: .touchUpInside)



        
        self.hideKeyboardWhenTappedAround()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DataStore.sharedInstance.getChallenges(forUser: uid!, completion: {
            self.myChallenges = DataStore.sharedInstance.userChallenges
            self.getMyChallenges {
                self.challengeView.myChallengesView.reloadData()
            }

        })
    }

    func onProfile(_ sender: UIBarButtonItem) {
        let vc = ProfileUpdateVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        if tableView == challengeView.myChallengesView {
            rows = myChallenges.count
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = FitnessCell()
        
        if tableView == challengeView.myChallengesView {
            cell = tableView.dequeueReusableCell(withIdentifier: "fitnessCell", for: indexPath) as! FitnessCell
            cell.setLabels(forChallenge: myChallenges[indexPath.row])

        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == challengeView.myChallengesView {
            let challengeDetailVC = ChallengeDetailVC()
            challengeDetailVC.setChallenge(challenge: myChallenges[indexPath.row])
            //            present(challengeDetailVC, animated: true, completion: nil)
            navigationController?.pushViewController(challengeDetailVC, animated: true)

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

    func segueFindChallenge() {

        let vc = FindChallengesVC()
        let navVC = NavigationController(rootViewController: vc)
        vc.modalPresentationStyle = .fullScreen
        self.present(navVC, animated: true, completion: nil)
    }

    
    func getMyChallenges(completion: @escaping () -> Void) {
        myChallenges = myChallenges.sorted(by: { (challenge1, challenge2) -> Bool in
            guard let date1 = challenge1.endDate, let date2 = challenge2.endDate else {return false}
            return date1 < date2
        })
        completion()
        
    }


}


