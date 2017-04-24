//
//  ChallengesView.swift
//  TeamFitnessApp
//
//  Created by Alessandro Musto on 4/19/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class ChallengesView: FitnessView {


  var myChallengesLabel: TitleLabel!
  var createPublicChallengeLabel: TitleLabel!
  var createChallengeButton: FitnessButton!
  var findChallengeButton: FitnessButton!

  var myChallengesView: UITableView!



  override init(frame: CGRect) {
    super.init(frame: frame)
    comInit()
    setConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    comInit()
    setConstraints()
  }

  func comInit() {
    myChallengesLabel = TitleLabel()
    self.addSubview(myChallengesLabel)
    myChallengesLabel.translatesAutoresizingMaskIntoConstraints = false
    myChallengesLabel.textAlignment = .center
    myChallengesLabel.changeFontSize(to: 20)
    myChallengesLabel.reverseColors()
    myChallengesLabel.set(text: "my group challenges")

    findChallengeButton = FitnessButton()
    self.addSubview(findChallengeButton)
    findChallengeButton.translatesAutoresizingMaskIntoConstraints = false
    findChallengeButton.set(text: "find public challenges")
    findChallengeButton.changeFontSize(to: 18)


    createPublicChallengeLabel = TitleLabel()
    self.addSubview(createPublicChallengeLabel)
    createPublicChallengeLabel.translatesAutoresizingMaskIntoConstraints = false
    createPublicChallengeLabel.textAlignment = .center
    createPublicChallengeLabel.changeFontSize(to: 20)
    createPublicChallengeLabel.reverseColors()
    createPublicChallengeLabel.numberOfLines = 2
    createPublicChallengeLabel.set(text: "...or...")

    myChallengesView = UITableView()
    self.addSubview(myChallengesView)
    myChallengesView.translatesAutoresizingMaskIntoConstraints = false
    myChallengesView.backgroundColor = UIColor.clear

    createChallengeButton = FitnessButton()
    self.addSubview(createChallengeButton)
    createChallengeButton.translatesAutoresizingMaskIntoConstraints = false
    createChallengeButton.set(text: "create public challenge")
    createChallengeButton.changeFontSize(to: 18)
  }



  func setConstraints() {

    myChallengesLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    myChallengesLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 70).isActive = true
    myChallengesLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1, constant: -20).isActive = true
    myChallengesLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.053, constant: 0).isActive = true

    myChallengesView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    myChallengesView.topAnchor.constraint(equalTo: myChallengesLabel.bottomAnchor, constant:8).isActive = true
    myChallengesView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
    myChallengesView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.40).isActive = true

    findChallengeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    findChallengeButton.topAnchor.constraint(equalTo: myChallengesView.bottomAnchor, constant: 10).isActive = true
    findChallengeButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1, constant: -30).isActive = true
    findChallengeButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.053, constant: 0).isActive = true

    createPublicChallengeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    createPublicChallengeLabel.topAnchor.constraint(equalTo: findChallengeButton.bottomAnchor, constant:8).isActive = true

    createPublicChallengeLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1, constant: -20).isActive = true
    createPublicChallengeLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.053, constant: 0).isActive = true

    createChallengeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    createChallengeButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1, constant: -30).isActive = true
    createChallengeButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.053, constant: 0).isActive = true
    createChallengeButton.topAnchor.constraint(equalTo: createPublicChallengeLabel.bottomAnchor, constant: 10).isActive = true


  }



}
