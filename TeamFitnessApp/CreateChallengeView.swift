//
//  CreateChallengeView.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/19/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class CreateChallengeView: FitnessView {
    
    let challengeTitleLabel = FitnessLabel()
    let challengeNameField = FitnessTextField()
    let teamIndicator = FitnessLabel()
    let teamSearchBar = UISearchBar()
    let publicButton = PublicButton()
    let teamsTableView = UITableView()
    let startDatePicker = FitnessDatePickerView()
    let endDatePicker = FitnessDatePickerView()
    let goalPicker = GoalPickerView()
    let nextButton = FitnessButton()
    let previousButton = FitnessButton()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadUI()
        setConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
        setConstraints()
    }
    
    func loadUI() {
        self.addSubview(challengeTitleLabel)
        
        challengeTitleLabel.text = "New Challenge"
        
        self.addSubview(challengeNameField)
        challengeNameField.setPlaceholder(toText: "Name challenge")
        
        self.addSubview(teamIndicator)
        if teamIndicator.text == nil {
            teamIndicator.set(text: "Find team to add new challenge:")
        }
        teamIndicator.reverseColors()
        
        self.addSubview(teamSearchBar)
        teamSearchBar.placeholder = "Find team"
        teamSearchBar.searchBarStyle = .minimal
        
        self.addSubview(publicButton)
        publicButton.reverseColors()
        publicButton.setTitle("Public?", for: .normal)
        teamSearchBar.isUserInteractionEnabled = true
        teamSearchBar.alpha = 1.0
        
        self.addSubview(teamsTableView)
        teamsTableView.backgroundColor = UIColor.clear
        teamsTableView.isHidden = true
        
        self.addSubview(goalPicker)
        self.bringSubview(toFront: goalPicker.stepper)
        self.addSubview(startDatePicker)
        startDatePicker.alpha = 0
        startDatePicker.setTitle(toString: "Challenge Start Date:")
        endDatePicker.setTitle(toString: "Challenge End Date:")
        
        self.addSubview(endDatePicker)
        endDatePicker.alpha = 0
        
        self.addSubview(nextButton)
        nextButton.setTitle("➡", for: .normal)
        self.addSubview(previousButton)
        previousButton.setTitle("Cancel", for: .normal)
    }
    
    func setConstraints() {
        
        challengeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        challengeTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        challengeTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 75).isActive = true
        challengeTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        challengeTitleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        
        challengeNameField.setConstraints(toSuperview: self, belowView: challengeTitleLabel)
        
        teamIndicator.setConstraints(toSuperView: self, belowView: challengeNameField)
        
        teamSearchBar.constrainVertically(belowView: teamIndicator, widthMultiplier: 0.5, heightMultiplier: 0.05)
        
        publicButton.setConstraints(nextToView: teamSearchBar)
        
        teamsTableView.constrainVertically(belowView: teamSearchBar, widthMultiplier: 0.8, heightMultiplier: 0.25)
        
        goalPicker.constrainVertically(belowView: teamSearchBar, widthMultiplier: 0.8, heightMultiplier: 0.5)
        
        startDatePicker.setConstraints(toSuperView: self, belowView: teamSearchBar)
        
        endDatePicker.setConstraints(toSuperView: self, belowView: startDatePicker)
        
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.leftAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        nextButton.topAnchor.constraint(equalTo: endDatePicker.bottomAnchor, constant: 10).isActive = true
        nextButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        nextButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        
        previousButton.translatesAutoresizingMaskIntoConstraints = false
        previousButton.rightAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        previousButton.topAnchor.constraint(equalTo: endDatePicker.bottomAnchor, constant: 10).isActive = true
        previousButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        previousButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
    
    }
    
    
}
