//
//  TrophyVC.swift
//  TeamFitnessApp
//
//  Created by Alessandro Musto on 4/11/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import Firebase

class TrophyVC: UIViewController {

    var user: User!
    var trophyView: TrophyView!
    var oldChallenges = [Challenge]()


    override func viewDidLoad() {
        super.viewDidLoad()

        trophyView = TrophyView(frame: self.view.bounds)
        self.view = trophyView

        fetchUser()

        self.navigationItem.setTitle(text: "trophies")

        let profileButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_person"), style: .plain, target: self, action: #selector(onProfile(_:)))
        navigationItem.setRightBarButton(profileButton, animated: false)

        trophyView.tableView.delegate = self
        trophyView.tableView.dataSource = self
        trophyView.tableView.register(FitnessCell.self, forCellReuseIdentifier: "fitnessCell")

    }

    func fetchUser() {
        if let uid = FIRAuth.auth()!.currentUser?.uid {
            FirebaseManager.fetchUser(withFirebaseUID: uid) { (user) in
                DispatchQueue.main.async {
                    self.user = user
                    self.trophyView.user = user
                    self.getOldChallenges()
                }
            }
        }
    }

    func getOldChallenges() {
        if user.oldChallengeIDs.count > 0 {
            for challenge in user.oldChallengeIDs {
                FirebaseManager.fetchOldChallenge(withChallengeID: challenge, completion: { (oldChallenge) in
                    DispatchQueue.main.async {
                        self.oldChallenges.append(oldChallenge)
                        if self.oldChallenges.count == self.user.oldChallengeIDs.count {
                            self.trophyView.tableView.reloadData()
                        }

                    }
                })
            }
        }
    }
}

extension TrophyVC: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return oldChallenges.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = FitnessCell()
        cell = tableView.dequeueReusableCell(withIdentifier: "fitnessCell", for: indexPath) as! FitnessCell
        cell.setLabels(forChallenge: oldChallenges[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let challengeDetailVC = ChallengeDetailVC()
        challengeDetailVC.setChallenge(challenge: oldChallenges[indexPath.row])
        navigationController?.pushViewController(challengeDetailVC, animated: true)
    }
    
    func onProfile(_ sender: UIBarButtonItem) {
        let vc = ProfileUpdateVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
