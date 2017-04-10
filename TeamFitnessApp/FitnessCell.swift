//
//  FitnessCell.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/7/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class FitnessCell: UITableViewCell {

    var nameLabel = FitnessLabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        
    }
    
    private func commonInit() {
        self.backgroundColor = UIColor.clear
        setupLabels()
    }
    
    func setupLabels() {
        self.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5).isActive = true
        nameLabel.reverseColors()
    }
    
    func setLabels(forTeam team: Team) {
        self.nameLabel.text = team.name
    }
    
    func setLabels(forChallenge challenge: Challenge) {
        self.nameLabel.text = challenge.name
    }
    
    func setLabels(forUser user: User) {
        self.nameLabel.text = user.name
    }
}
