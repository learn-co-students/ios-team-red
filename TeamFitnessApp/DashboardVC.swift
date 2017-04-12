//  DashboardVC.swift
//  TeamFitnessApp
//
//  Created by Alessandro Musto on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import Firebase

class DashboardVC: UIViewController {

  var dashboadView: DashboardView!
  var user = FIRAuth.auth()?.currentUser
  var testUser: User!
  var challenges = [Challenge]()
  var goals = [Goal]()


    override func viewDidLoad() {
        super.viewDidLoad()
      navigationItem.title = "Fitness Baby"
      let button = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(onLogout(_:)))

      navigationItem.setLeftBarButton(button, animated: false)

      createTestUser()
      dashboadView = DashboardView(frame: view.frame)
      view = dashboadView
      dashboadView.user = testUser

      dashboadView.tableView.delegate = self
      dashboadView.tableView.dataSource = self

    }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    getChallenges()
  }

  func createTestUser() {
    let goal = Goal(type: .exerciseTime, value: 60)
    let goal1 = Goal(type: .caloriesBurned, value: 800)
    let goals = [goal, goal1]

    testUser = User(name: "Sandro", sex: "male", height: 62, weight: 200, teamIDs: [], challengeIDs: ["-KhU260OQP09rXtwC43M", "-KhUTSehLIDfg7x7rlu-", "-KhUUzDXDcupM2xozo3D", "-KhUgr27zft-EDgW3ot6"], goals: goals, email: "ales.musto@gmail.com", uid: "ueIVp3UT2mVJHwVT8Pgoz0GPfbK2")

  }

  func getChallenges() {
    if testUser.challengeIDs.count > 0 {
      for challenge in testUser.challengeIDs {
        FirebaseManager.fetchChallenge(withChallengeID: challenge, completion: { (challenge) in
          DispatchQueue.main.async {
            self.challenges.append(challenge)
            self.dashboadView.tableView.reloadData()
          }
        })
      }
    }
  }

  func onLogout(_ sender: UIBarButtonItem) {
    FirebaseManager.logoutUser { (response) in
      print(response)

      NotificationCenter.default.post(name: .closeDashboardVC, object: nil)

    }
  }
}

extension DashboardVC: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return challenges.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    cell.textLabel?.text = challenges[indexPath.row].name
    cell.backgroundColor = UIColor.clear
    cell.textLabel?.textColor = UIColor.foregroundOrange
    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

  }

}
