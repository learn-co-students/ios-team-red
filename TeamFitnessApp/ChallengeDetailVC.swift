//
//  ChallengeDetailVC.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/9/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class ChallengeDetailVC: UIViewController {
    
    let challenge: Challenge? = nil
    
    var titleLabel = TitleLabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = FitnessView()
        setupViews()

        // Do any additional setup after loading the view.
    }

    func setupViews() {
        self.view.addSubview(titleLabel)
        titleLabel.setConstraints(toView: self.view)
        titleLabel.setText(toString: "Challenge Info")
    }
    
    func setChallenge(challenge: Challenge) {
        self.titleLabel.setText(toString: challenge.name)
    }
}
