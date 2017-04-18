//
//  FitnessLabel.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/4/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class FitnessLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
//        self.font = UIFont(name: "Gurmukhi MN", size: 17.0)
        self.font = UIFont(name: "Fresca-Regular", size: 17.00)
        self.textColor = UIColor.backgroundBlack
        self.textAlignment = .center

        self.backgroundColor = UIColor.foregroundOrange
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
    }
     
    func reverseColors() {
        self.textColor = UIColor.stormysea
        self.backgroundColor = UIColor.clear
    }
    
    func changeFontSize(to newFontSize: CGFloat) {
        self.font = UIFont(name: "Fresca-Regular", size: newFontSize)
    }
    
    func setConstraints(toSuperView superView: UIView, belowView view: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: superView.centerXAnchor).isActive = true
        self.topAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        self.heightAnchor.constraint(equalTo: superView.heightAnchor, multiplier: 0.05).isActive = true
        self.widthAnchor.constraint(equalTo: superView.widthAnchor, multiplier: 0.8).isActive = true
    }
    
    func set(text: String) {
      let attributes: NSDictionary = [
        NSKernAttributeName:CGFloat(3.0)

      ]
      let attributedTitle = NSAttributedString(string: text.uppercased(), attributes:attributes as? [String : AnyObject])

      self.attributedText = attributedTitle
      self.reverseColors()
    }

}



