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
    let valueLabel = UILabel()
    let stepper = UIStepper()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.foregroundOrange
        self.layer.cornerRadius = 5
        self.addSubview(titleLabel)
        self.addSubview(goalPicker)
        self.addSubview(valueLabel)
        self.addSubview(stepper)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        titleLabel.reverseColors()
        titleLabel.text = "Set Challenge Goal:"
        
        goalPicker.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        goalPicker.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        goalPicker.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        goalPicker.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        goalPicker.delegate = self
        goalPicker.dataSource = self
        
        valueLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        valueLabel.topAnchor.constraint(equalTo: goalPicker.bottomAnchor).isActive = true
        valueLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        valueLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        valueLabel.text = "0"
        
        stepper.rightAnchor.constraint(equalTo: valueLabel.leftAnchor).isActive = true
        stepper.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stepper.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        stepper.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
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
            return "Excersise Time"
        default:
            return "This should not exist" //TODO: - handle this error better
        }
    }
    
}
