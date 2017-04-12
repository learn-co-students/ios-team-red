//
//  ChallengesVCExtension.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/12/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import UIKit

extension ChallengesVC {
    
    func setupSubViews() {
        self.view = mainView
        setupMyChallenges()
        setupChallengeSearch()
        setupCreateChallengeButton()
    }
    
    func setupMyChallenges() {
        view.addSubview(myChallengesLabel)
        myChallengesLabel.translatesAutoresizingMaskIntoConstraints = false
        myChallengesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myChallengesLabel.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        myChallengesLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        myChallengesLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        myChallengesLabel.textAlignment = .center
        myChallengesLabel.changeFontSize(to: 20)
        myChallengesLabel.reverseColors()
        myChallengesLabel.text = "My Challenges:"
        
        view.addSubview(myChallengesView)
        myChallengesView.translatesAutoresizingMaskIntoConstraints = false
        myChallengesView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myChallengesView.topAnchor.constraint(equalTo: myChallengesLabel.bottomAnchor).isActive = true
        myChallengesView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        myChallengesView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        myChallengesView.backgroundColor = UIColor.clear
    }

    func setupChallengeSearch() {
        view.addSubview(challengeSearchBar)
        challengeSearchBar.translatesAutoresizingMaskIntoConstraints = false
        challengeSearchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        challengeSearchBar.topAnchor.constraint(equalTo: myChallengesView.bottomAnchor, constant: 20).isActive = true
        challengeSearchBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        challengeSearchBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        challengeSearchBar.placeholder = "Find Challenge by Name"
        challengeSearchBar.backgroundColor = UIColor.foregroundOrange
        
        view.addSubview(publicChallengesView)
        publicChallengesView.translatesAutoresizingMaskIntoConstraints = false
        publicChallengesView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        publicChallengesView.topAnchor.constraint(equalTo: challengeSearchBar.bottomAnchor, constant: 25).isActive = true
        publicChallengesView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        publicChallengesView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        publicChallengesView.backgroundColor = UIColor.clear
    }
    
    func setupCreateChallengeButton() {
        view.addSubview(createChallengeButton)
        createChallengeButton.translatesAutoresizingMaskIntoConstraints = false
        createChallengeButton.leftAnchor.constraint(equalTo: challengeSearchBar.rightAnchor).isActive = true
        createChallengeButton.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        createChallengeButton.topAnchor.constraint(equalTo: challengeSearchBar.topAnchor).isActive = true
        createChallengeButton.bottomAnchor.constraint(equalTo: challengeSearchBar.bottomAnchor).isActive = true
        createChallengeButton.setTitle("+", for: .normal)
        createChallengeButton.changeFontSize(to: 18)
        createChallengeButton.addTarget(self, action: #selector(segueCreateChallenge), for: .touchUpInside)
    }
    
    func segueCreateChallenge() {
        let createChallengeVC = CreateChallengeVC()
        present(createChallengeVC, animated: true, completion: nil)
    }
    
    func setupSearchBar() {
        
    }
}
