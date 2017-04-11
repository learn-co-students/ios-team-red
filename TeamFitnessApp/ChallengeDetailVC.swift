//
//  ChallengeDetailVC.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/9/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class ChallengeDetailVC: UIViewController {
    
    let challenge: Challenge? = nil
    
    let titleLabel = TitleLabel()
    let startDateLabel = FitnessLabel()
    let endDateLabel = FitnessLabel()
    let goalPieChart = CustomPieChartView()
    
//    var goal: [String:Double]
//    var creator: String?
//    var userUIDs = [String]()
//    var isPublic: Bool?
//    var teamID: String?
//    var id: String?
//    var name: String

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = FitnessView()
        setupViews()
        getChartData()

    }

    func setupViews() {
        self.view.addSubview(titleLabel)
        titleLabel.setConstraints(toView: self.view)
        titleLabel.setText(toString: "Challenge Info")
        
        self.view.addSubview(goalPieChart)
        goalPieChart.translatesAutoresizingMaskIntoConstraints = false
        goalPieChart.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        goalPieChart.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        goalPieChart.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        goalPieChart.heightAnchor.constraint(equalTo: goalPieChart.widthAnchor).isActive = true
        
    }
    
    func setChallenge(challenge: Challenge) {
        self.titleLabel.setText(toString: challenge.name)
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
}
