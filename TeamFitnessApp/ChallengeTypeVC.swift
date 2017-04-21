//
//  ChallengeTypeVC.swift
//  TeamFitnessApp
//
//  Created by Alessandro Musto on 4/20/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class ChallengeTypeVC: UIViewController {

    var tableView: UITableView!
    var goalChallenges = [Challenge]()
    var challenges = [Challenge]()
    var goal: Goal! {
        didSet {
            self.navigationItem.setTitle(text: "\(goal.type.rawValue) Challenges")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whitewash


        tableView = UITableView(frame: view.frame)
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FitnessCell.self, forCellReuseIdentifier: "fitnessCell")

        fileterChallenges()
    }

    func fileterChallenges() {
        for challenge in challenges {
            if challenge.goal?.type == goal.type {
                goalChallenges.append(challenge)
            }
        }
        tableView.reloadData()
    }
}



//MARK: - Table view data source and delegate

extension ChallengeTypeVC: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goalChallenges.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fitnessCell", for: indexPath) as! FitnessCell
        cell.setLabels(forChallenge: goalChallenges[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let challengeDetailVC = ChallengeDetailVC()
        challengeDetailVC.setChallenge(challenge: goalChallenges[indexPath.row])
        self.navigationController?.pushViewController(challengeDetailVC, animated: true)
    }
}
