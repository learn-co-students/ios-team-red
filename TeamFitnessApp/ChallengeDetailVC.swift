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

        // Do any additional setup after loading the view.
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
        // refactor challenge goal as an instance of Goal
       // goalPieChart.setData(goal: challenge.goal, current: <#T##Double#>)
        
    }
    
    func setChallenge(challenge: Challenge) {
        self.titleLabel.setText(toString: challenge.name)
    }
}
