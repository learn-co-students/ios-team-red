//  DashboardVC.swift
//  TeamFitnessApp
//
//  Created by Alessandro Musto on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import Firebase

class DashboardVC: UIViewController, DashboardVCProtocol {

  var dashboadView: DashboardView!
  var user = FIRAuth.auth()!.currentUser
  var testUser: User!
  var challenges = [Challenge]()
  var goals = [Goal]()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
      let titleLabel = FitnessLabel(frame: CGRect(x:0, y:0, width: 150, height: 45))
      titleLabel.set(text: "Fitness baby")
      titleLabel.textColor = UIColor.whitewash
      navigationItem.titleView = titleLabel
      let button = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(onLogout(_:)))

      navigationItem.setLeftBarButton(button, animated: false)


      let profileButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_person"), style: .plain, target: self, action: #selector(onProfile(_:)))
      navigationItem.setRightBarButton(profileButton, animated: false)


      fetchUser()
      dashboadView = DashboardView(frame: view.frame)
      view = dashboadView
       dashboadView.delegate = self
//        
//        print(testUser.sex)
//        print(testUser.name)

//
//      dashboadView.tableView.delegate = self
//      dashboadView.tableView.dataSource = self

    }
    
    func pressChallengeButton () {
        let vc = CreateChallengeVC()
        print("challenge Button pressed")
        self.present(vc, animated: true, completion: nil)
    }



  func fetchUser() {
    if let uid = user?.uid {
    FirebaseManager.checkForPrevious(uid: uid, completion: { (previousExists) in
        if !previousExists {
            NotificationCenter.default.post(name: .closeDashboardVC, object: nil)
        }
    })
      FirebaseManager.fetchUser(withFirebaseUID: uid) { (user) in
        DispatchQueue.main.async {
          self.testUser = user
          self.dashboadView.user = user
//          self.getChallenges()
        }
      }
    }



//    let goal = Goal(type: .exerciseTime, value: 60)
//    let goal1 = Goal(type: .caloriesBurned, value: 800)
//    let goals = [goal, goal1]

//
//    testUser = User(name: "Sandro", sex: "male", height: 62, weight: 200, teamIDs: [], challengeIDs: ["-KhU260OQP09rXtwC43M", "-KhUTSehLIDfg7x7rlu-", "-KhUUzDXDcupM2xozo3D", "-KhUgr27zft-EDgW3ot6"], goals: goals, email: "ales.musto@gmail.com", uid: "ueIVp3UT2mVJHwVT8Pgoz0GPfbK2")


  }


//  func getChallenges() {
//    if testUser.challengeIDs.count > 0 {
//      self.challenges = []
//      for challenge in testUser.challengeIDs {
//        FirebaseManager.fetchChallenge(withChallengeID: challenge, completion: { (challenge) in
//          DispatchQueue.main.async {
//            self.challenges.append(challenge)
//            self.dashboadView.tableView.reloadData()
//          }
//        })
//      }
//    }
//  }

  func onLogout(_ sender: UIBarButtonItem) {
    FirebaseManager.logoutUser { (response) in
      print(response)

      NotificationCenter.default.post(name: .closeDashboardVC, object: nil)

    }
  }

  func onProfile(_ sender: UIBarButtonItem) {
    let vc = ProfileUpdateVC()
//    vc.firUser = self.user
    navigationController?.pushViewController(vc, animated: true)
  }

  
}

//extension DashboardVC: UITableViewDelegate, UITableViewDataSource {
//
//  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//    return challenges.count
//  }
//
//  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//    cell.textLabel?.text = challenges[indexPath.row].name
//    cell.backgroundColor = UIColor.clear
//    cell.textLabel?.textColor = UIColor.foregroundOrange
//    return cell
//  }
//
//  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let challengeDetailVC = ChallengeDetailVC()
//    challengeDetailVC.setChallenge(challenge: challenges[indexPath.row])
//    navigationController?.pushViewController(challengeDetailVC, animated: true)
//    tableView.deselectRow(at: indexPath, animated: true)
//  }
//  
//
//
//}
