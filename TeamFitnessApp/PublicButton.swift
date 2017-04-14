//
//  publicButton.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/12/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class PublicButton: FitnessButton {

    func setConstraints(nextToView view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        self.rightAnchor.constraint(equalTo: view.leftAnchor, constant: -10).isActive = true
        self.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 2.0).isActive = true
        self.reverseColors()
        self.setTitle("Public?", for: .normal)
    }

}
