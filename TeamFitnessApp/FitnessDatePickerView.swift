//
//  FitnessDatePickerView.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/10/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class FitnessDatePickerView: UIView {

    let titleLabel = FitnessLabel()
    let datePicker = UIDatePicker()
    
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
        self.addSubview(datePicker)
        datePicker.datePickerMode = .dateAndTime
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.topAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        titleLabel.reverseColors()
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        datePicker.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        datePicker.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        datePicker.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75)
        datePicker.minimumDate = Date()
    }
    
    func setTitle(toString title: String) {
        self.titleLabel.text = title
    }

}
