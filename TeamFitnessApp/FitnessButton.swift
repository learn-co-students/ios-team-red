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
        commoInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commoInit()
    }

    func commoInit() {
        self.titleLabel?.font = UIFont(name: "Gurmukhi MN", size: 17.0)
        self.setTitleColor(UIColor.backgroundImageBlue, for: .normal)
        self.backgroundColor = UIColor.foregroundOrange
        self.layer.cornerRadius = 5
    }
    
    func reverseColors() {
        self.setTitleColor(UIColor.foregroundOrange, for: .normal)
        self.backgroundColor = UIColor.clear
    }
}
