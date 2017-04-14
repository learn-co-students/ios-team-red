//
//  UIViewExtensions.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/13/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func constrainVertically(belowView view: UIView, widthMultiplier: CGFloat, heightMultiplier: CGFloat) {
        guard let superview = self.superview else {return}
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: heightMultiplier).isActive = true
        self.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: widthMultiplier).isActive = true
    }
}
