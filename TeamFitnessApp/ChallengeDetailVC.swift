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
    
    let titleLabel = TitleLabel()
    let startDateLabel = FitnessLabel()
    let endDateLabel = FitnessLabel()
    let leadersTable = UITableView()
    let joinButton = FitnessButton()
    
    let leaders = [User]()
    var userScores = [(String, Double)]()
    var userIsChallengeMember: Bool = false
    
    let goalPieChart = CustomPieChartView()
    let leadersChart = CustomHorizontalBarChart()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = FitnessView()
        setupViews()
        
        
    }

    func setupViews() {
        self.view.addSubview(titleLabel)
        titleLabel.setConstraints(toView: self.view, andViewController: self)
        titleLabel.setText(toString: "Challenge Info")
        
        self.view.addSubview(goalPieChart)
        goalPieChart.translatesAutoresizingMaskIntoConstraints = false
        goalPieChart.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        goalPieChart.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        goalPieChart.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        goalPieChart.heightAnchor.constraint(equalTo: goalPieChart.widthAnchor).isActive = true
        getChartData()
        
        self.view.addSubview(leadersChart)
        leadersChart.translatesAutoresizingMaskIntoConstraints = false
        leadersChart.topAnchor.constraint(equalTo: goalPieChart.bottomAnchor).isActive = true
        leadersChart.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        leadersChart.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        leadersChart.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4).isActive = true
        
        if !userIsChallengeMember {
            self.view.addSubview(joinButton)
            joinButton.translatesAutoresizingMaskIntoConstraints = false
            joinButton.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor).isActive = true
            joinButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            joinButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
            joinButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
            joinButton.setTitle("Join Challenge", for: .normal)
            joinButton.addTarget(self, action: #selector(joinChallenge), for: .touchUpInside)
        }
        
    }
    
    func joinChallenge() {
        guard let challengeID = self.challenge?.id, let challengeIsPublic = self.challenge?.isPublic, let uid = FIRAuth.auth()?.currentUser?.uid else {return}
        if challengeIsPublic {
            FirebaseManager.add(childID: uid, toParentId: challengeID, parentDataType: .publicChallenges, childDataType: .users) {}
            FirebaseManager.add(childID: challengeID, toParentId: uid, parentDataType: .users, childDataType: .publicChallenges) {}
        } else {
            FirebaseManager.add(childID: uid, toParentId: challengeID, parentDataType: .challenges, childDataType: .users) { }
            FirebaseManager.add(childID: challengeID, toParentId: uid, parentDataType: .users, childDataType: .challenges) {}
        }
        joinButton.isHidden = true
    }
    
    func setChallenge(challenge: Challenge) {
        self.challenge = challenge
        getChartData()
        self.titleLabel.setText(toString: challenge.name)
        
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
                        self.goalPieChart.setData(goal: goalValue, current: calories)
                    }
                }
            })
        case.distance:
            HealthKitManager.sharedInstance.getDistance(fromDate: startDate, toDate: Date(), completion: { (distance, error) in
                if let distance = distance {
                    DispatchQueue.main.async {
                        self.goalPieChart.setData(goal: goalValue, current: distance)
                    }
                }
            })
        case.exerciseTime:
            HealthKitManager.sharedInstance.getExerciseTime(fromDate: startDate, toDate: Date(), completion: { (time, error) in
                if let time = time {
                    DispatchQueue.main.async {
                        self.goalPieChart.setData(goal: goalValue, current: time)
                    }
                }
            })
        case .stepCount:
            HealthKitManager.sharedInstance.getSteps(fromDate: startDate, toDate: Date(), completion: { (steps, error) in
                if let steps = steps {
                    DispatchQueue.main.async {
                        self.goalPieChart.setData(goal: goalValue, current: steps)
                    }
                }
            })
        }
    }
    
    func getLeaders(completion: @escaping () -> Void) {
        guard let uids = challenge?.userUIDs, let challengeID = challenge?.id else {return} //TODO: - handle this error mo bettah
        for uid in uids {
            FirebaseManager.fetchUser(withFirebaseUID: uid, completion: { (user) in
                guard let uid = user.uid, let challenge = self.challenge else {return}
                FirebaseManager.fetchChallengeProgress(forChallengeID: challengeID, andForUID: uid, challengeIsPublic: challenge.isPublic, completion: { (response) in
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
        //determine five leaders
        var leaderScores = [(String, Double)]()
        userScores.sort { $0.1 > $1.1} //sort userScores from highest score to lowest score
        var num: Int = 0
        if userScores.count >= 5 {
            num = 4
        } else {
            num = userScores.count - 1
        }
        for i in 0...num {
            leaderScores.append(userScores[i])
        }
        print(leaderScores)
        leadersChart.setData(group: leaderScores)
    }
}
