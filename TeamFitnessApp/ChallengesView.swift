//
//  ChallengesView.swift
//  TeamFitnessApp
//
//  Created by Alessandro Musto on 4/19/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class ChallengesView: FitnessView {


  var myChallengesLabel: FitnessLabel!
  var publicChallengesLabel: FitnessLabel!
  var createChallengeButton: FitnessButton!

  var challengeSearchBar: UISearchBar!

  var myChallengesView: UITableView!
  var publicChallengesView: UITableView!



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
    myChallengesLabel = FitnessLabel()
    self.addSubview(myChallengesLabel)
    myChallengesLabel.translatesAutoresizingMaskIntoConstraints = false
    myChallengesLabel.textAlignment = .center
    myChallengesLabel.changeFontSize(to: 20)
    myChallengesLabel.reverseColors()
    myChallengesLabel.set(text: "my challenges")

    myChallengesView = UITableView()
    self.addSubview(myChallengesView)
    myChallengesView.translatesAutoresizingMaskIntoConstraints = false
    myChallengesView.backgroundColor = UIColor.clear

    challengeSearchBar = UISearchBar()
    self.addSubview(challengeSearchBar)
    challengeSearchBar.translatesAutoresizingMaskIntoConstraints = false
    challengeSearchBar.placeholder = "Find Challenge by Name"
    challengeSearchBar.searchBarStyle = .minimal

    publicChallengesView = UITableView()
    self.addSubview(publicChallengesView)
    publicChallengesView.translatesAutoresizingMaskIntoConstraints = false
    publicChallengesView.backgroundColor = UIColor.clear

    createChallengeButton = FitnessButton()
    self.addSubview(createChallengeButton)
    createChallengeButton.translatesAutoresizingMaskIntoConstraints = false
    createChallengeButton.setTitle("+", for: .normal)
    createChallengeButton.changeFontSize(to: 18)
  }



  func setConstraints() {

    myChallengesLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    myChallengesLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 75).isActive = true
    myChallengesLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
    myChallengesLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.1).isActive = true

    myChallengesView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    myChallengesView.topAnchor.constraint(equalTo: myChallengesLabel.bottomAnchor).isActive = true
    myChallengesView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
    myChallengesView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true

    challengeSearchBar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    challengeSearchBar.topAnchor.constraint(equalTo: myChallengesView.bottomAnchor, constant: 20).isActive = true
    challengeSearchBar.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.05).isActive = true
    challengeSearchBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.6).isActive = true

    publicChallengesView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    publicChallengesView.topAnchor.constraint(equalTo: challengeSearchBar.bottomAnchor, constant: 25).isActive = true
    publicChallengesView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
    publicChallengesView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true

    createChallengeButton.leftAnchor.constraint(equalTo: challengeSearchBar.rightAnchor).isActive = true
    createChallengeButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    createChallengeButton.topAnchor.constraint(equalTo: challengeSearchBar.topAnchor).isActive = true
    createChallengeButton.bottomAnchor.constraint(equalTo: challengeSearchBar.bottomAnchor).isActive = true


  }



}
