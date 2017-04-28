//
//  ReportButton.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/20/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class ReportButton: FitnessButton {

    enum isMonitoring {
        case team, user
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    override func commonInit() {
        self.set(text: "Report image")
        self.changeFontSize(to: 18)
        //        self.reverseColors()
        self.addTarget(self, action: #selector(reportOffense), for: .touchUpInside)

    }

    func reportOffense () {
        print("Hey! That's offensive!")
    }
    
}
