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
    
    func flashRed() {
        UIView.animateKeyframes(withDuration: 0.8, delay: 0, options: .calculationModeLinear, animations: {
            let holdColor = self.backgroundColor
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2, animations: {
                self.backgroundColor = UIColor.red
            })
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.2, animations: {
                self.backgroundColor = holdColor
            })
            UIView.addKeyframe(withRelativeStartTime: 0.4, relativeDuration: 0.2, animations: {
                self.backgroundColor = UIColor.red
            })
            UIView.addKeyframe(withRelativeStartTime: 0.6, relativeDuration: 0.2, animations: {
                self.backgroundColor = holdColor
            })
        }, completion: nil)
    }
}
