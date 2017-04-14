//
//  TitleLabel.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/9/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class TitleLabel: FitnessLabel {
    
    func setText(toString text: String) {
        self.text = text
    }
    
    func setConstraints(toView view: UIView, andViewController viewController: UIViewController) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.topAnchor.constraint(equalTo: viewController.topLayoutGuide.bottomAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        self.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
        self.textAlignment = .center
        self.changeFontSize(to: 28)
        self.reverseColors()
    }
    
}
