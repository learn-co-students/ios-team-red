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
  var createPublicChallengeLabel: FitnessLabel!
  var createChallengeButton: FitnessButton!
  var findPublicLabel: FitnessLabel!
  

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
    myChallengesLabel.set(text: "my group challenges")

    findPublicLabel = FitnessLabel()
    self.addSubview(findPublicLabel)
    findPublicLabel.translatesAutoresizingMaskIntoConstraints = false
    findPublicLabel.textAlignment = .center
    findPublicLabel.changeFontSize(to: 20)
    findPublicLabel.reverseColors()
    findPublicLabel.set(text: "find public challenges")

    createPublicChallengeLabel = FitnessLabel()
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

    challengeSearchBar = UISearchBar()
    self.addSubview(challengeSearchBar)
    challengeSearchBar.translatesAutoresizingMaskIntoConstraints = false


    challengeSearchBar.placeholder = "find challenge by name"
    challengeSearchBar.setPlaceholderAttributes()
    challengeSearchBar.setTextAttributes()
    challengeSearchBar.searchBarStyle = .minimal

    publicChallengesView = UITableView()
    self.addSubview(publicChallengesView)
    publicChallengesView.translatesAutoresizingMaskIntoConstraints = false
    publicChallengesView.backgroundColor = UIColor.clear

    createChallengeButton = FitnessButton()
    self.addSubview(createChallengeButton)
    createChallengeButton.translatesAutoresizingMaskIntoConstraints = false
    createChallengeButton.set(text: "create public challenge")
    createChallengeButton.changeFontSize(to: 18)
  }



  func setConstraints() {

    myChallengesLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    myChallengesLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 70).isActive = true
    myChallengesLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.80).isActive = true

    myChallengesView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    myChallengesView.topAnchor.constraint(equalTo: myChallengesLabel.bottomAnchor, constant:8).isActive = true
    myChallengesView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
    myChallengesView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25 ).isActive = true

    findPublicLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    findPublicLabel.topAnchor.constraint(equalTo: myChallengesView.bottomAnchor, constant: 10).isActive = true
    findPublicLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.80).isActive = true

    challengeSearchBar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    challengeSearchBar.topAnchor.constraint(equalTo: findPublicLabel.bottomAnchor, constant: 3).isActive = true
    challengeSearchBar.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.10).isActive = true
    challengeSearchBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true

    publicChallengesView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    publicChallengesView.topAnchor.constraint(equalTo: challengeSearchBar.bottomAnchor, constant: 25).isActive = true
    publicChallengesView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
    publicChallengesView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.20).isActive = true


    createPublicChallengeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    createPublicChallengeLabel.topAnchor.constraint(equalTo: publicChallengesView.bottomAnchor, constant: 10).isActive = true
    createPublicChallengeLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true

    createChallengeButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    createChallengeButton.widthAnchor.constraint(equalToConstant: 300).isActive = true
    createChallengeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    createChallengeButton.topAnchor.constraint(equalTo: createPublicChallengeLabel.bottomAnchor, constant: 10).isActive = true


  }



}
