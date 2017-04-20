//
//  ReportButton.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/20/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class ReportButton: FitnessButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func commonInit() {
        self.set(text: "Report offensive image")
        self.changeFontSize(to: 18)
        self.backgroundColor = UIColor.raspberry
        self.addTarget(self, action: #selector(reportOffense), for: .touchUpInside)
    }
    
    func reportOffense () {
        print("Hey! That's offensive!")
    }
    
}
