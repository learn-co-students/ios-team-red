//
//  GoalsView.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/10/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import UIKit

protocol GoalsViewDelegate: class {
    func pressCreateUserButton()
}



class GoalsView: FitnessView {
    
    
    var activityMinutesADay: UITextField!
    var caloriesADay: UITextField!
    var createUserButton: FitnessButton!
    weak var delegate: GoalsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadGoalsViewUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pressCreateUserButton(sender: UIButton) {
        delegate?.pressCreateUserButton()
    }

    
    func loadGoalsViewUI() {
        
        activityMinutesADay = UITextField()
        self.addSubview(activityMinutesADay)
        activityMinutesADay.translatesAutoresizingMaskIntoConstraints = false
        activityMinutesADay.layer.cornerRadius = 5
        activityMinutesADay.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        activityMinutesADay.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        activityMinutesADay.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        activityMinutesADay.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        activityMinutesADay.backgroundColor = UIColor.white

        
        caloriesADay = UITextField()
        self.addSubview(caloriesADay)
        caloriesADay.translatesAutoresizingMaskIntoConstraints = false
        caloriesADay.layer.cornerRadius = 5
        caloriesADay.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        caloriesADay.topAnchor.constraint(equalTo: activityMinutesADay.bottomAnchor, constant: 10).isActive = true
        caloriesADay.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3).isActive = true
        caloriesADay.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
        caloriesADay.backgroundColor = UIColor.white

        
        createUserButton = FitnessButton()
        self.addSubview(createUserButton)
        createUserButton.translatesAutoresizingMaskIntoConstraints = false
        createUserButton.setTitle("Create New User", for: UIControlState.normal)
        createUserButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        createUserButton.topAnchor.constraint(equalTo: caloriesADay.bottomAnchor, constant: 10).isActive = true
        createUserButton.addTarget(self, action: #selector(pressCreateUserButton), for: .touchUpInside)

        
        
            
            
            
            
            
            
            
            
    }
    
    
    
    
}
