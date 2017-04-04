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
        commoInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commoInit()
    }
    
    func commoInit() {
        self.font = UIFont(name: "Gurmukhi MN", size: 17.0)
        self.textColor = UIColor.backgroundBlack
        self.backgroundColor = UIColor.foregroundOrange
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 5
    }
    
    func reverseColors() {
        self.textColor = UIColor.foregroundOrange
        self.backgroundColor = UIColor.clear
    }

}
