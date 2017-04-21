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
    
    var goal = Goal(type: .miles, value: 0)

    var stepMultiplier: Int = 1
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
        titleLabel.set(text: "Set Challenge Goal")
        
        goalPicker.translatesAutoresizingMaskIntoConstraints = false
        goalPicker.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        goalPicker.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        goalPicker.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        goalPicker.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
        goalPicker.delegate = self
        goalPicker.dataSource = self
        goalPicker.layer.cornerRadius = 5
        goalPicker.tintColor = UIColor.whitewash
        goalPicker.backgroundColor = UIColor.raspberry
        
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        valueLabel.topAnchor.constraint(equalTo: goalPicker.bottomAnchor).isActive = true
        valueLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        valueLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
        valueLabel.text = "\(stepper.value) \(goalTag)"
        valueLabel.reverseColors()
        valueLabel.changeFontSize(to: 24)
        
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: -8).isActive = true
        stepper.topAnchor.constraint(equalTo: valueLabel.bottomAnchor).isActive = true
        stepper.heightAnchor.constraint(equalToConstant: 25).isActive = true
        stepper.widthAnchor.constraint(equalToConstant: 75).isActive = true
        stepper.layer.cornerRadius = 5
        stepper.isUserInteractionEnabled = true
        stepper.backgroundColor = UIColor.raspberry
        stepper.addTarget(self, action: #selector(stepperChanged(sender:)), for: .valueChanged)
    }
// MARK: - picker view data source


    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {

        let attributes: NSDictionary = [
            NSFontAttributeName:UIFont(name: "Fresca-Regular", size: 17)!,
            NSKernAttributeName:CGFloat(3.0),
            NSForegroundColorAttributeName:UIColor.whitewash,
            ]

        switch row {
        case 0:
            let text = "distance"
            return NSAttributedString(string: text.uppercased(), attributes:attributes as? [String : AnyObject])
        case 1:
            let text = "Step Count"
            return  NSAttributedString(string: text.uppercased(), attributes:attributes as? [String : AnyObject])
        case 2:
            let text = "Calories Burned"
            return  NSAttributedString(string: text.uppercased(), attributes:attributes as? [String : AnyObject])
        case 3:
            let text = "Exercise Time"
            return  NSAttributedString(string: text.uppercased(), attributes:attributes as? [String : AnyObject])
        default:
            let text = "This should not exist"
            return  NSAttributedString(string: text.uppercased(), attributes:attributes as? [String : AnyObject])
        }
    }


    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 4
    }

//MARK: - picker view delegate
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        stepper.value = 0
        switch row {
        case 0:
            goal.type = .miles
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
            goal.type = .exerciseMinutes
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
