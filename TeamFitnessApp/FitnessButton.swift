//
//  FitnessButton.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/4/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class FitnessButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        self.titleLabel?.font = UIFont(name: "Fresca-Regular", size: 17.0)
        self.setTitleColor(UIColor.whitewash, for: .normal)
        self.backgroundColor = UIColor.lagoon
        self.layer.cornerRadius = 5


        setShadow()
    }

    func setShadow() {
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.raspberry.cgColor
        self.layer.masksToBounds = true

        self.layer.cornerRadius = 5.0
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 1.0

    }

    func reverseColors() {
        self.setTitleColor(UIColor.lagoon, for: .normal)
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 0.0
        self.layer.shadowOpacity = 0.0

    }

    func changeFontSize(to newFontSize: CGFloat) {
        self.titleLabel?.font = UIFont(name: "Fresca-Regular", size: newFontSize)
    }

    func set(text: String) {
        let attributes: NSDictionary = [
            NSFontAttributeName:UIFont(name: "Fresca-Regular", size: 17)!,
            NSKernAttributeName:CGFloat(3.0),
            NSForegroundColorAttributeName:UIColor.whitewash,
            ]
        let attributedTitle = NSAttributedString(string: text.uppercased(), attributes:attributes as? [String : AnyObject])

        self.setAttributedTitle(attributedTitle, for: .normal)
    }

    func setReversed(text: String) {
        let attributes: NSDictionary = [
            NSFontAttributeName:UIFont(name: "Fresca-Regular", size: 13)!,
            NSKernAttributeName:CGFloat(3.0),
            NSForegroundColorAttributeName:UIColor.lagoon,
            NSBackgroundColorAttributeName:UIColor.clear

        ]
        let attributedTitle = NSAttributedString(string: text.uppercased(), attributes:attributes as? [String : AnyObject])
        
        self.setAttributedTitle(attributedTitle, for: .normal)
    }
}
