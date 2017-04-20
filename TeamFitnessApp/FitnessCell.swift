//
//  FitnessCell.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/7/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class FitnessCell: UITableViewCell {

  var nameLabel: FitnessLabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
        setConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setConstraints()

    }
    
    private func commonInit() {
        self.backgroundColor = UIColor.clear
        nameLabel = FitnessLabel()
        nameLabel.changeFontSize(to: 14)
        self.contentView.addSubview(nameLabel)
    }


    func setConstraints() {
      nameLabel.translatesAutoresizingMaskIntoConstraints = false
      nameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
      nameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
      nameLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
      nameLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
    }

    func setLabels(forTeam team: Team) {
        self.nameLabel.set(text: team.name)
    }
    
    func setLabels(forChallenge challenge: Challenge) {
        self.nameLabel.set(text: challenge.name)
    }
    
    func setLabels(forUser user: User) {
        self.nameLabel.set(text: user.name)
    }
}
