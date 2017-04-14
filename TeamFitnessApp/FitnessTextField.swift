//
//  FitnessTextField.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/12/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class FitnessTextField: UITextField {

    func setConstraints(toSuperview superView: UIView, belowView view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: superView.heightAnchor, multiplier: 0.05).isActive = true
        self.widthAnchor.constraint(equalTo: superView.widthAnchor, multiplier: 0.5).isActive = true
        self.backgroundColor = UIColor.foregroundOrange
        self.textColor = UIColor.backgroundBlack
        self.layer.cornerRadius = 5
    }
    
    func setPlaceholder(toText text: String) {
        self.placeholder = text
    }

}
