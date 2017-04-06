//
//  TeamsCell.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class TeamsCell: UITableViewCell {
    
    var team: Team? {
        didSet {
            teamNameLabel.text = team?.id
        }
    }
    let teamNameLabel = FitnessLabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.clear
        print("Content view frame: \(self.contentView.frame)")
        setupLabels()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupLabels() {
        self.addSubview(teamNameLabel)
        teamNameLabel.translatesAutoresizingMaskIntoConstraints = false
        teamNameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        teamNameLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        teamNameLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor).isActive = true
        teamNameLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.5).isActive = true
        teamNameLabel.reverseColors()
    }

}
