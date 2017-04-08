//
//  CreateTeamVC.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/7/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import Firebase

class CreateTeamVC: UIViewController {
    
    let titleLabel = FitnessLabel()
    var userID = FIRAuth.auth()?.currentUser?.uid
    let teamNameField = UITextField()
    let submitButton = FitnessButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = FitnessView()
        setupLabels()
        setUpTextFields()
        setupButtons()
        userID = "TEST USER ID" //TODO: - remove this line after login is functional
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func setupLabels() {
        self.view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        titleLabel.textAlignment = .center
        titleLabel.changeFontSize(to: 28)
        titleLabel.reverseColors()
        titleLabel.text = "New Team"
    }
    
    func setUpTextFields() {
        self.view.addSubview(teamNameField)
        teamNameField.translatesAutoresizingMaskIntoConstraints = false
        teamNameField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        teamNameField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        teamNameField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        // teamNameField.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        teamNameField.backgroundColor = UIColor.foregroundOrange
        teamNameField.layer.cornerRadius = 5
        teamNameField.placeholder = "Enter team name"
    }
    
    func setupButtons() {
        self.view.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        submitButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        submitButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15).isActive = true
        submitButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(createNewTeam), for: .touchUpInside)
    }
    
    func createNewTeam() {
        print("CREATE TEAM fired")
        if let userID = userID {
            if let teamName = teamNameField.text {
                var team = Team(userUIDs: [userID], captainID: userID, challengeIDs: [], imageURL: "NO IMAGE", name: teamName)
                FirebaseManager.addNew(team: team, completion: { (teamID) in
                    team.id = teamID
                    print("Team created: \(team.name) with ID: \(team.id!)")
                })
            }
        } else {
            //TODO: - Add animation indicating text fields are not filled out
        }
    }

}
