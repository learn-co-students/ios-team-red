//
//  ChallengeDetailVC.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/9/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import Firebase

class ChallengeDetailVC: UIViewController {
    
    var challenge: Challenge? = nil {
        didSet {
            guard let challenge = self.challenge else {return}
            if let uid = FIRAuth.auth()?.currentUser?.uid {
                if challenge.userUIDs.contains(uid) {
                    userIsChallengeMember = true
                }
            }
        }
    }
    
    var challengeDetailView: ChallengeDetailView? = nil
    let leaders = [User]()
    var userScores = [(String, Double)]()
    var userIsChallengeMember: Bool = false
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        challengeDetailView = ChallengeDetailView(frame: view.frame)
        self.view = challengeDetailView
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
    }
    
    func setChallenge(challenge: Challenge) {
        self.challenge = challenge
        getChartData()
        challengeDetailView?.topLabel.text = "\(challenge.name)"
        
        getLeaders {
            DispatchQueue.main.async {
                self.displayLeaders()
            }
        }
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
        case.distance:
            HealthKitManager.sharedInstance.getDistance(fromDate: startDate, toDate: Date(), completion: { (distance, error) in
                if let distance = distance {
                    DispatchQueue.main.async {
                        self.challengeDetailView?.goalPieChart.setData(goal: goalValue, current: distance)
                    }
                }
            })
        case.exerciseTime:
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
    
    func getLeaders(completion: @escaping () -> Void) {
        guard let uids = challenge?.userUIDs, let challengeID = challenge?.id else {return} //TODO: - handle this error mo bettah - set leaderboard to default image
        for uid in uids {
            FirebaseManager.fetchUser(withFirebaseUID: uid, completion: { (user) in
                guard let uid = user.uid, let challenge = self.challenge else {return}
                FirebaseManager.fetchChallengeProgress(forChallengeID: challengeID, andForUID: uid, challengeIsPublic: challenge.isPublic, completion: { (response) in
                    self.userScores.removeAll()
                    switch response {
                    case .successfulData(let data):
                        let userScore: (String, Double) = (user.name, data)
                        self.userScores.append(userScore)
                    case .failure(let failString):
                        print(failString)
                    default:
                        print("FirebaseManager returned an invalid response")
                    }
                    completion()
                })
            })
        }
    }
    
    fileprivate func displayLeaders() {
        guard !userScores.isEmpty else {return} //TODO: - something to set default image for chart if no data exists
        var leaderScores = [(String, Double)]()
        userScores.sort { $0.1 > $1.1} //sort userScores from highest score to lowest score
        
        let num: Int = (userScores.count >= 5 ? 4 : userScores.count - 1)
        
        for i in 0...num {
            leaderScores.append(userScores[i])
        }
        challengeDetailView?.leadersChart.setData(group: leaderScores)
    }
}
