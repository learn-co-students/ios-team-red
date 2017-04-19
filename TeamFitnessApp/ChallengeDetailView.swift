//
//  ChallengeDetailView.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/19/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class ChallengeDetailView: FitnessView {
    
    let topLabel = FitnessLabel()
    let startDateLabel = FitnessLabel()
    let endDateLabel = FitnessLabel()
    let leadersTable = UITableView()
    let joinButton = FitnessButton()
    
    let goalPieChart = CustomPieChartView()
    let leadersChart = CustomHorizontalBarChart()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    func setConstraints() {
        
        self.addSubview(topLabel)
        topLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        topLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        topLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        topLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
        topLabel.text = "Challenge Info"
        
        self.addSubview(goalPieChart)
        goalPieChart.translatesAutoresizingMaskIntoConstraints = false
        goalPieChart.topAnchor.constraint(equalTo: topLabel.bottomAnchor).isActive = true
        goalPieChart.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        goalPieChart.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        goalPieChart.heightAnchor.constraint(equalTo: goalPieChart.widthAnchor).isActive = true
        
        self.addSubview(leadersChart)
        leadersChart.translatesAutoresizingMaskIntoConstraints = false
        leadersChart.topAnchor.constraint(equalTo: goalPieChart.bottomAnchor).isActive = true
        leadersChart.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        leadersChart.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        leadersChart.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
    }
    
    func displayJoinButton() {
        self.addSubview(joinButton)
        joinButton.translatesAutoresizingMaskIntoConstraints = false
        joinButton.bottomAnchor.constraint(equalTo: self.topAnchor).isActive = true
        joinButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        joinButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        joinButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true
        joinButton.setTitle("Join Challenge", for: .normal)
    }
}
