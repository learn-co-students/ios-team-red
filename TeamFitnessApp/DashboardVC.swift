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
  var user = FIRAuth.auth()!.currentUser
  var testUser: User!
  var challenges = [Challenge]()
  var goals = [Goal]()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
    self.navigationItem.setTitle(text: "Groupfit")


      let profileButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_person"), style: .plain, target: self, action: #selector(onProfile(_:)))
      navigationItem.setRightBarButton(profileButton, animated: false)


      fetchUser()
      dashboadView = DashboardView(frame: view.frame)
      view = dashboadView

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
        }
      }
    }
  }


  func onProfile(_ sender: UIBarButtonItem) {
    let vc = ProfileUpdateVC()
    navigationController?.pushViewController(vc, animated: true)
  }

  
}


