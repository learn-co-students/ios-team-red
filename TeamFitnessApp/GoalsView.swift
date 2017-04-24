//
//  GoalsView.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/10/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import UIKit
import Firebase


protocol GoalsViewDelegate: class {
    func pressCreateUserButton()
}



class GoalsView: FitnessView {
    

    var introLabel: FitnessLabel!
    var minuteLabel: FitnessLabel!
    var calorieLabel: FitnessLabel!
    var activityMinutesADay = FitnessField()
    var caloriesADay = FitnessField()
    var createUserButton: FitnessButton!
    weak var delegate: GoalsViewDelegate?
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      loadGoalsViewUI()
      setConstraints()

    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      loadGoalsViewUI()
      setConstraints()
    }
    
    func pressCreateUserButton(sender: UIButton) {
        delegate?.pressCreateUserButton()
    }

    
    func loadGoalsViewUI() {

        introLabel = FitnessLabel()
        self.addSubview(introLabel)
        introLabel.translatesAutoresizingMaskIntoConstraints = false
        introLabel.textAlignment = NSTextAlignment.center
        introLabel.numberOfLines = 2
        introLabel.reverseColors()
        introLabel.changeFontSize(to: 20.0)
        introLabel.set(text: "set up two daily challenges to get started")

        minuteLabel = FitnessLabel()
        self.addSubview(minuteLabel)
        minuteLabel.translatesAutoresizingMaskIntoConstraints = false
        minuteLabel.textAlignment = NSTextAlignment.center
        minuteLabel.numberOfLines = 3
        minuteLabel.reverseColors()
        minuteLabel.changeFontSize(to: 16.0)
        minuteLabel.set(text: "how many minutes do you want to be active each day?")

        activityMinutesADay = FitnessField()
        self.addSubview(activityMinutesADay)
        activityMinutesADay.translatesAutoresizingMaskIntoConstraints = false
        activityMinutesADay.keyboardType = UIKeyboardType.numberPad
        activityMinutesADay.setPlaceholder(text: "active minutes")


        calorieLabel = FitnessLabel()
        self.addSubview(calorieLabel)
        calorieLabel.translatesAutoresizingMaskIntoConstraints = false
        calorieLabel.textAlignment = NSTextAlignment.center
        calorieLabel.reverseColors()
        calorieLabel.numberOfLines = 2

        calorieLabel.changeFontSize(to: 16.0)
        calorieLabel.set(text: "how many calories would you like to burn each day?")


        caloriesADay = FitnessField()
        self.addSubview(caloriesADay)
        caloriesADay.translatesAutoresizingMaskIntoConstraints = false
        caloriesADay.keyboardType = UIKeyboardType.numberPad
        caloriesADay.setPlaceholder(text: "calories")


        
        createUserButton = FitnessButton()
        self.addSubview(createUserButton)
        createUserButton.translatesAutoresizingMaskIntoConstraints = false
        createUserButton.set(text: "get started")
        createUserButton.addTarget(self, action: #selector(pressCreateUserButton), for: .touchUpInside)

    }

  func setConstraints() {



    introLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
    introLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
    introLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true

    minuteLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
    minuteLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
    minuteLabel.topAnchor.constraint(equalTo: introLabel.bottomAnchor, constant: 50).isActive = true

    activityMinutesADay.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
    activityMinutesADay.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
    activityMinutesADay.topAnchor.constraint(equalTo: minuteLabel.bottomAnchor, constant: 10).isActive = true
    activityMinutesADay.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true

    calorieLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
    calorieLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
    calorieLabel.topAnchor.constraint(equalTo: activityMinutesADay.bottomAnchor, constant: 20).isActive = true

    caloriesADay.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
    caloriesADay.topAnchor.constraint(equalTo: calorieLabel.bottomAnchor, constant: 10).isActive = true
    caloriesADay.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4).isActive = true
    caloriesADay.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true


    createUserButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
    createUserButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
    createUserButton.topAnchor.constraint(equalTo: caloriesADay.bottomAnchor, constant: 30).isActive = true

  }


}
