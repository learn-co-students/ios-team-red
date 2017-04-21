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
    let challengeNameField = FitnessField()
    let startDatePicker = FitnessDatePickerView()
    let endDatePicker = FitnessDatePickerView()
    let goalPicker = GoalPickerView()
    let nextButton = FitnessButton()

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
        challengeTitleLabel.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(challengeNameField)
        challengeNameField.translatesAutoresizingMaskIntoConstraints = false
        challengeNameField.autocorrectionType = .no
        challengeNameField.setPlaceholder(text: "Name challenge")
        
        
        self.addSubview(goalPicker)
        self.bringSubview(toFront: goalPicker.stepper)
        self.addSubview(startDatePicker)
        startDatePicker.alpha = 0
        startDatePicker.setTitle(toString: "Challenge Start Date")
        endDatePicker.setTitle(toString: "Challenge End Date")
        
        self.addSubview(endDatePicker)
        endDatePicker.alpha = 0
        
        self.addSubview(nextButton)
        nextButton.set(text: "now set duration")

    }
    
    func setConstraints() {
        
        challengeTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        challengeTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 75).isActive = true
        challengeTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        challengeTitleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        
        challengeNameField.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        challengeNameField.topAnchor.constraint(equalTo: challengeTitleLabel.bottomAnchor).isActive = true
        challengeNameField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        challengeNameField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true

        goalPicker.constrainVertically(belowView: challengeNameField, widthMultiplier: 0.8, heightMultiplier: 0.5)
        
        startDatePicker.setConstraints(toSuperView: self, belowView: challengeTitleLabel)
        
        endDatePicker.setConstraints(toSuperView: self, belowView: startDatePicker)
        
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        nextButton.topAnchor.constraint(equalTo: endDatePicker.bottomAnchor, constant: 10).isActive = true
        nextButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.55).isActive = true
        nextButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        

    
    }
    
    
}
