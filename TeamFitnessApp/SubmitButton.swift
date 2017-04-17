//
//  SubmitButton.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/13/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import UIKit

class SubmitButton: FitnessButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func setConstraints(toView view: UIView, andViewConroller viewController: UIViewController) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.bottomAnchor.constraint(equalTo: viewController.bottomLayoutGuide.topAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15).isActive = true
        self.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        self.setTitle("Submit", for: .normal)
    }
    
}
