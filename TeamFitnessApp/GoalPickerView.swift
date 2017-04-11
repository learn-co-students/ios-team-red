//
//  GoalPickerView.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/11/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class GoalPickerView: UIView, UIPickerViewDataSource, UIPickerViewDelegate {

    let titleLabel = FitnessLabel()
    let goalPicker = UIPickerView()
    let valueLabel = FitnessLabel()
    let stepper = UIStepper()
    
    var goal = Goal(type: .distance, value: 0)

    var stepMultiplier: Int = 5
    var goalTag: String = ""
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.clear
        self.layer.cornerRadius = 5
        self.addSubview(titleLabel)
        self.addSubview(goalPicker)
        self.addSubview(valueLabel)
        self.addSubview(stepper)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        titleLabel.reverseColors()
        titleLabel.text = "Set Challenge Goal:"
        
        goalPicker.translatesAutoresizingMaskIntoConstraints = false
        goalPicker.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        goalPicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        goalPicker.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        goalPicker.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
        goalPicker.delegate = self
        goalPicker.dataSource = self
        goalPicker.backgroundColor = UIColor.foregroundOrange
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        valueLabel.topAnchor.constraint(equalTo: goalPicker.bottomAnchor).isActive = true
        valueLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        valueLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
        valueLabel.text = "\(stepper.value) \(goalTag)"
        valueLabel.reverseColors()
        valueLabel.changeFontSize(to: 24)
        
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stepper.topAnchor.constraint(equalTo: valueLabel.bottomAnchor).isActive = true
        stepper.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
        stepper.widthAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        stepper.contentHorizontalAlignment = .fill
        stepper.isUserInteractionEnabled = true
        stepper.backgroundColor = UIColor.foregroundOrange
        stepper.addTarget(self, action: #selector(stepperChanged(sender:)), for: .valueChanged)
    }
// MARK: - picker view data source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }

//MARK: - picker view delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "Distance"
        case 1:
            return "Sept Count"
        case 2:
            return "Calories Burned"
        case 3:
            return "Exercise Time"
        default:
            return "This should not exist" //TODO: - handle this error better
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stepper.value = 0
        switch row {
        case 0:
            goal.type = .distance
            goalTag = "Miles"
            stepMultiplier = 1
        case 1:
            goal.type = .stepCount
            goalTag = "Steps"
            stepMultiplier = 1000
        case 2:
            goal.type = .caloriesBurned
            goalTag = "Calories Burned"
            stepMultiplier = 1000
        case 3:
            goal.type = .exerciseTime
            goalTag = "Exercise Minutes"
            stepMultiplier = 5
        default:
            print("Goal Picker View error: Out of range")
        }
        goal.setValue(from: stepper.value * Double(stepMultiplier))
        valueLabel.text = "\(Int(stepper.value) * stepMultiplier) \(goalTag)"
    }
    
//MARK: - Stepper functions
    
    func stepperChanged(sender: UIStepper!) {
        print("Stepper changed called")
        print(sender.value)
        goal.value = stepper.value * Double(stepMultiplier)
        valueLabel.text = "\(Int(stepper.value) * stepMultiplier) \(goalTag)"
    }
}
