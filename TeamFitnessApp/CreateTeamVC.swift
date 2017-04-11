//
//  CreateTeamVC.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/7/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import Firebase

class CreateTeamVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let titleLabel = TitleLabel()
    var user: User?
    var userID = FIRAuth.auth()?.currentUser?.uid
    let teamNameField = UITextField()
    let submitButton = FitnessButton()
    let imageButton = FitnessButton()
    let teamImage = UIImageView()
    var chosenImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.delegate = self
        
        if let userID = userID {
            FirebaseManager.fetchUser(withFirebaseUID: userID, completion: { (user) in
                self.user = user
            })
        }
        
        self.view = FitnessView()
        setupLabels()
        setUpTextFields()
        setupButtons()
    }
    
    func setupLabels() {
        self.view.addSubview(titleLabel)
        titleLabel.setConstraints(toView: self.view)
        titleLabel.setText(toString: "New Team")
        titleLabel.text = "New Team"
    }
    
    func setUpTextFields() {
        self.view.addSubview(teamNameField)
        teamNameField.translatesAutoresizingMaskIntoConstraints = false
        teamNameField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        teamNameField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        teamNameField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.8).isActive = true
        teamNameField.backgroundColor = UIColor.foregroundOrange
        teamNameField.layer.cornerRadius = 5
        teamNameField.placeholder = "Enter team name"
    }
    
    func setupButtons() {
        
        self.view.addSubview(submitButton)
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        submitButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        submitButton.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.topAnchor).isActive = true
        submitButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15).isActive = true
        submitButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        submitButton.setTitle("Submit", for: .normal)
        submitButton.addTarget(self, action: #selector(createNewTeam), for: .touchUpInside)
        
        self.view.addSubview(imageButton)
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        imageButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        imageButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        imageButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        imageButton.setTitle("+ Team Image", for: .normal)
        imageButton.addTarget(self, action: #selector(getTeamImage), for: .touchUpInside)
        
        imageButton.addSubview(teamImage)
        teamImage.translatesAutoresizingMaskIntoConstraints = false
        teamImage.leftAnchor.constraint(equalTo: imageButton.leftAnchor).isActive = true
        teamImage.rightAnchor.constraint(equalTo: imageButton.rightAnchor).isActive = true
        teamImage.topAnchor.constraint(equalTo: imageButton.topAnchor).isActive = true
        teamImage.bottomAnchor.constraint(equalTo: imageButton.bottomAnchor).isActive = true
    }
    
    func createNewTeam() {
        print("CREATE TEAM fired")
        if let userID = userID {
            if let teamName = teamNameField.text {
                navigationController?.popViewController(animated: true)
                //self.dismiss(animated: true, completion: nil)//TODO: - Something is making this happen very slowly - queueing?
                var team = Team(userUIDs: [userID], captainID: userID, challengeIDs: [], imageURL: "NO IMAGE", name: teamName)
                FirebaseManager.addNew(team: team, completion: { (teamID) in
                    team.id = teamID
                    if var user = self.user {
                        user.teamIDs.append(teamID)
                        FirebaseManager.save(user: user)
                    }
                    print("Team created: \(team.name) with ID: \(team.id!)")
                })
                
                guard let teamID = team.id, let chosenImage = chosenImage else {return} //TODO: - handle this error better
                    FirebaseStoreageManager.upload(teamImage: chosenImage, withTeamID: teamID, completion: { (response) in
                        switch response {
                        case let .failure(failString):
                            print(failString)
                        case let .succesfulUpload(successString):
                            print(successString)
                        default:
                            print("Invalid reponse returned from Firebase storage")
                        }
                })
            }
        } else {
            //TODO: - Add animation indicating text fields are not filled out
        }
        
        
    }
    
    func getTeamImage() {
        let imagePicker  = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        imagePicker.isModalInPopover = true
        imagePicker.modalPresentationStyle = .overCurrentContext
        navigationController?.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        teamImage.image = chosenImage
        navigationController?.dismiss(animated: true, completion: nil)

    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        navigationController?.dismiss(animated: true, completion: nil)

    }

}
