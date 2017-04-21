//
//  ChallengeDetailVC.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/9/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.


import UIKit
import Firebase

class ChallengeDetailVC: UIViewController {

    var challengeDetailView: ChallengeDetailView!
    var challenge: Challenge? = nil {
        didSet {
            guard let challenge = self.challenge else {return}

            if let uid = FIRAuth.auth()?.currentUser?.uid {
                if challenge.userUIDs[uid] != nil {
                    userIsChallengeMember = true
                }
            }
        }
    }
    
    let leaders = [User]()
    var userScores = [(String, Double)]()
    var userIsChallengeMember: Bool = false
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setTitle(text: "group challenges")
        challengeDetailView = ChallengeDetailView(frame: view.frame)
        self.view = challengeDetailView
        challengeDetailView.challenge = challenge
        if !userIsChallengeMember {
            challengeDetailView?.displayJoinButton()
            challengeDetailView?.joinButton.addTarget(self, action: #selector(joinChallenge), for: .touchUpInside)
        }
    }
    
    func joinChallenge() {
        guard let challengeID = self.challenge?.id, let uid = FIRAuth.auth()?.currentUser?.uid else {return}
        FirebaseManager.add(childID: uid, toParentId: challengeID, parentDataType: .challenges, childDataType: .users) {}
        FirebaseManager.add(childID: challengeID, toParentId: uid, parentDataType: .users, childDataType: .challenges) {}
        challengeDetailView?.joinButton.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
    
    func setChallenge(challenge: Challenge) {
        self.challenge = challenge
        getChartData()
        challengeDetailView?.topLabel.text = "\(challenge.name)"
        
        setChartWithLeaders()
    }
    
    func getChartData() {
        guard let goalType = challenge?.goal?.type, let startDate = challenge?.startDate, let goalValue = challenge?.goal?.value else {return}
        switch goalType {
        case .caloriesBurned:
            HealthKitManager.sharedInstance.getCalories(fromDate: startDate, toDate: Date(), completion: { (calories, error) in
                if let calories = calories {
                    DispatchQueue.main.async {
                        self.challengeDetailView?.goalPieChart.setData(goal: goalValue, current: calories)
                    }
                }
            })
        case.miles:
            HealthKitManager.sharedInstance.getDistance(fromDate: startDate, toDate: Date(), completion: { (distance, error) in
                if let distance = distance {
                    DispatchQueue.main.async {
                        self.challengeDetailView?.goalPieChart.setData(goal: goalValue, current: distance)
                    }
                }
            })
        case.exerciseMinutes:
            HealthKitManager.sharedInstance.getExerciseTime(fromDate: startDate, toDate: Date(), completion: { (time, error) in
                if let time = time {
                    DispatchQueue.main.async {
                        self.challengeDetailView?.goalPieChart.setData(goal: goalValue, current: time)
                    }
                }
            })
        case .stepCount:
            HealthKitManager.sharedInstance.getSteps(fromDate: startDate, toDate: Date(), completion: { (steps, error) in
                if let steps = steps {
                    DispatchQueue.main.async {
                        self.challengeDetailView?.goalPieChart.setData(goal: goalValue, current: steps)
                    }
                }
            })
        }
    }
    

    func getUserValues(completion: @escaping ([(String, Double)]) -> ()) {
        var leaderArray = [(String, Double)]()
        for (userID, value) in (challenge?.userUIDs)! {
            FirebaseManager.fetchUser(withFirebaseUID: userID, completion: { (user) in
                leaderArray.append((user.name, value))
                if leaderArray.count == (self.challenge?.userUIDs)!.count {
                    completion(leaderArray)
                }
            })
        }


    }

    func setChartWithLeaders() {
        getUserValues { (userList) in
            if userList.count > 5 {
                let newArray = [userList[0], userList[1], userList[2], userList[3], userList[4]]
                DispatchQueue.main.async {
                    self.challengeDetailView.leadersChart.setData(group: newArray)
                }
            } else {
                DispatchQueue.main.async {
                    self.challengeDetailView.leadersChart.setData(group: userList)
                }
            }
        }
    }
}
