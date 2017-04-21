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
    var date = Date()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    func commonInit() {
        
        self.backgroundColor = UIColor.raspberry
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
        datePicker.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
//        datePicker.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        datePicker.minimumDate = Date()
        datePicker.addTarget(self, action: #selector(changeDate(sender:)), for: .valueChanged)
    }
    
    func setTitle(toString title: String) {
        self.titleLabel.set(text: title)
    }
    
    func changeDate(sender: UIDatePicker!) {
        date = sender.date
    }
    
    func setConstraints(toSuperView superView: UIView, belowView view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 50).isActive = true
        self.heightAnchor.constraint(equalTo: superView.heightAnchor, multiplier: 0.20).isActive = true
        self.widthAnchor.constraint(equalTo: superView.widthAnchor, multiplier: 0.7).isActive = true
    }
}
