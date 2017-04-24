//
//  FindChallengeCell.swift
//  TeamFitnessApp
//
//  Created by Alessandro Musto on 4/20/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class FindChallengeCell: UICollectionViewCell {

    var goal: Goal! {
        didSet {
            goalTypeLabel.set(text: goal.type.rawValue)
            goalTypeLabel.changeFontSize(to: 14)
            goalTypeLabel.adjustsFontSizeToFitWidth = true
            goalTypeLabel.textColor = UIColor.whitewash
        }
    }

    var goalTypeLabel: FitnessLabel!


    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {

        contentView.backgroundColor = UIColor.lagoon
        contentView.layer.cornerRadius = 10.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.raspberry.cgColor
        contentView.layer.masksToBounds = true

        layer.cornerRadius = 10.0
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2.0
        layer.shadowOpacity = 1.0


        goalTypeLabel = FitnessLabel()
        goalTypeLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(goalTypeLabel)



        setConstraints()
    }

    func setConstraints() {
        goalTypeLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        goalTypeLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        goalTypeLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, constant: -10).isActive = true


        
    }
    
    
}
