//
//  CreateChallengeVC.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/10/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import Firebase

class CreateChallengeVC: UIViewController, UISearchBarDelegate {
    
    var challengeIsPublic: Bool = false
    var team: Team? = nil
    var challenge: Challenge? = nil
    var user: User? = nil
    var uid: String? = FIRAuth.auth()?.currentUser?.uid
    let healthKitManager = HealthKitManager.sharedInstance
    
    var myTeams = [Team]()
    var filteredTeams = [Team]()
    
    var createChallengeView: CreateChallengeView?
    
    //MARK: Subviews
    
    var viewState: ViewState = .first
    
    //MARK: - properties being stored to create challenge instance:
    var challengeName: String? = nil
    var challengeStartDate: Date? = nil
    var challengeEndDate: Date? = nil
    var challengeGoal: Goal? = nil
    let challengeCreatorID = FIRAuth.auth()?.currentUser?.uid
    var challengeUserIDs: [String:Double] = [(FIRAuth.auth()?.currentUser?.uid)!:0]
    var challengeTeamID: String?
    
    enum ViewState {
        case first, second
    }
    
    override func viewDidLoad() {

        self.navigationItem.setTitle(text: "create challenge")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancel(_:)))

        super.viewDidLoad()
        createChallengeView = CreateChallengeView(frame: view.frame)
        self.view = createChallengeView
        setupViews()


        if challengeIsPublic {
            createChallengeView?.challengeTitleLabel.set(text: "new public challenge")
            createChallengeView?.challengeTitleLabel.changeFontSize(to: 20)
        } else {
            createChallengeView?.challengeTitleLabel.set(text: "new team challenge")
            createChallengeView?.challengeTitleLabel.changeFontSize(to: 20)
        }



    }
//MARK = setup view constraints
    func setupViews() {
        self.hideKeyboardWhenTappedAround()
        createChallengeView?.nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        
    }

// MARK: - button functions

    func nextButtonPressed() {
        if viewState == .first { //if the user is on the first screen of the CreateChallengeView, store the values in the text/search/picker fields, and move to the next screen
          if createChallengeView?.challengeNameField.text == "" {
            createChallengeView?.challengeNameField.flashRed()
          } else {
            storeFirstFields()
            moveToSecondFields()
          }



          } else if viewState == .second {
              storeSecondFields()
            
            if let challengeName = challengeName, let challengeStartDate = challengeStartDate, let challengeEndDate = challengeEndDate, let challengeGoal = challengeGoal, let challengeCreatorID = challengeCreatorID {

                let newChallenge = Challenge(name: challengeName, startDate: challengeStartDate, endDate: challengeEndDate, goal: challengeGoal, creatorID: challengeCreatorID, userUIDs: challengeUserIDs, isPublic: challengeIsPublic, team: challengeTeamID)

                FirebaseManager.addNew(challenge: newChallenge, completion: { (challengeID) in
                    guard let userUID = self.uid else {return}
                    FirebaseManager.add(childID: challengeID, toParentId: userUID, parentDataType: .users, childDataType: .challenges, completion: {
                        let alertVC = UIAlertController(title: "Challenge Created!", message: "", preferredStyle: .alert)
                        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { (_) in
                            FirebaseManager.updateChallengeData(challengeID: challengeID, userID: userUID, withData: 0) {
                                self.dismiss(animated: true, completion: nil)
                            }
                        })
                        alertVC.addAction(okAction)
                        self.present(alertVC, animated: true, completion: nil)
                    })
                    if !challengeIsPublic {
                        guard let teamID = team?.id else {return}
                        FirebaseManager.add(childID: challengeID, toParentId: teamID, parentDataType: .teams, childDataType: .challenges, completion: {
                        })

                    }
                    
                })
                
            } else {
                //TODO: - if user has not entered all information needed to create challenge, indicate that to them
            }
        }
    }
    
    private func storeFirstFields() {
        challengeName = createChallengeView?.challengeNameField.text
        createChallengeView?.challengeNameField.isHidden = true
        createChallengeView?.challengeTitleLabel.isHidden = true
        challengeGoal = createChallengeView?.goalPicker.goal
        challengeTeamID = team?.id
    }
    
    private func moveToSecondFields() {
        createChallengeView?.goalPicker.hide()
        createChallengeView?.startDatePicker.show()
        createChallengeView?.endDatePicker.show()
        createChallengeView?.nextButton.set(text: "create")
        viewState = .second
    }
    
    private func storeSecondFields() {
        challengeStartDate = createChallengeView?.startDatePicker.date
        challengeEndDate = createChallengeView?.endDatePicker.date
    }
    
    func previousButtonPressed() {
        navigationController?.popViewController(animated: true)
    }

//MARK: - Firebase calls
    
    func getUser(completion: @escaping (User) -> Void) {
        guard let uid = FIRAuth.auth()?.currentUser?.uid else {return}
        FirebaseManager.fetchUser(withFirebaseUID: uid) { (user) in
            self.user = user
            completion(user)
        }
    }
    
    private func getTeams(forUser user: User, completion: @escaping () -> Void) {
        myTeams.removeAll()
        filteredTeams.removeAll()
        let teamList = user.teamIDs
        for teamID in teamList {
            FirebaseManager.fetchTeamOnce(withTeamID: teamID, completion: { (team) in
                if team.captainID == user.uid {
                    self.myTeams.append(team)
                    completion()
                }
            })
        }
    }

    func onCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    

}
