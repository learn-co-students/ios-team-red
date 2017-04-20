//
//  CreateTeamVC.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/7/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import Firebase

class CreateTeamVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    let titleLabel = TitleLabel()
    var user: User?
    var userID = FIRAuth.auth()?.currentUser?.uid
    let teamNameField = FitnessField()
    let submitButton = SubmitButton()
    let imageButton = FitnessButton()
    let teamImage = UIImageView()
    var chosenImage: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.setTitle(text: "create team")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancel(_:)))


        if let userID = userID {
            FirebaseManager.fetchUser(withFirebaseUID: userID, completion: { (user) in
                self.user = user
            })
        }
        self.view = FitnessView()
        setupLabels()
        setUpTextFields()
        setupButtons()
        self.hideKeyboardWhenTappedAround()
    }

    func setupLabels() {
        self.view.addSubview(titleLabel)
        titleLabel.setConstraints(toView: self.view, andViewController: self)
        titleLabel.set(text: "new team")
        titleLabel.changeFontSize(to: 23)
    }
    
    func setUpTextFields() {
        self.view.addSubview(teamNameField)
        teamNameField.constrainVertically(belowView: titleLabel, widthMultiplier: 0.8, heightMultiplier: 0.05)
        teamNameField.setPlaceholder(text: "enter team name")
    }
    
    func setupButtons() {
        
        self.view.addSubview(submitButton)
        submitButton.setConstraints(toView: self.view, andViewConroller: self)
        submitButton.addTarget(self, action: #selector(createTeamButtonPressed), for: .touchUpInside)
        
        self.view.addSubview(imageButton)
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        imageButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        imageButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        imageButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        imageButton.heightAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        imageButton.set(text: "+ team image")
        imageButton.addTarget(self, action: #selector(getTeamImage), for: .touchUpInside)
        
        imageButton.addSubview(teamImage)
        teamImage.translatesAutoresizingMaskIntoConstraints = false
        teamImage.leftAnchor.constraint(equalTo: imageButton.leftAnchor).isActive = true
        teamImage.rightAnchor.constraint(equalTo: imageButton.rightAnchor).isActive = true
        teamImage.topAnchor.constraint(equalTo: imageButton.topAnchor).isActive = true
        teamImage.bottomAnchor.constraint(equalTo: imageButton.bottomAnchor).isActive = true
    }
    
    func createTeamButtonPressed() {
        createNewTeam {
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func createNewTeam(completion: () -> Void) {
        if let userID = userID {
            guard teamNameField.text != "" else {
                teamNameField.flashRed()
                return
            }
            if let teamName = teamNameField.text {
                var team = Team(userUIDs: [userID], captainID: userID, challengeIDs: [], name: teamName)
                FirebaseManager.addNew(team: team, completion: { (teamID) in
                    team.id = teamID
                    if let uid = self.user?.uid {
                        FirebaseManager.add(childID: teamID, toParentId: uid, parentDataType: .users, childDataType: .teams) {
                            completion()
                        }
                    }
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
            if teamNameField.text == nil {
                teamNameField.flashRed()
            }
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

    func onCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

}
