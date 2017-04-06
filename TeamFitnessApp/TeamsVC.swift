//
//  TeamsViewController.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class TeamsVC: UIViewController {
    
    let screenBounds = UIScreen.main.bounds
    let mainView = FitnessView()
    let titleLabel = FitnessLabel()
    let myTeamsLabel = FitnessLabel()
    let myTeamsView = UITableView()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupSubViews() {
        self.view = mainView
        setupTitle()
        setUpMyTeams()
    }
    
    func setupTitle() {
        self.view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        titleLabel.textAlignment = .center
        titleLabel.changeFontSize(to: 28)
        titleLabel.reverseColors()
        titleLabel.text = "Teams"
    }
    
    func setUpMyTeams() {
        view.addSubview(myTeamsLabel)
        myTeamsLabel.translatesAutoresizingMaskIntoConstraints = false
        myTeamsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myTeamsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        myTeamsLabel.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        myTeamsLabel.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        myTeamsLabel.textAlignment = .center
        myTeamsLabel.changeFontSize(to: 20)
        myTeamsLabel.reverseColors()
        myTeamsLabel.text = "My Teams:"
        
        view.addSubview(myTeamsView)
        myTeamsView.translatesAutoresizingMaskIntoConstraints = false
        myTeamsView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        myTeamsView.topAnchor.constraint(equalTo: myTeamsLabel.bottomAnchor).isActive = true
        myTeamsView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        myTeamsView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25).isActive = true
        myTeamsView.backgroundColor = UIColor.green
        
    }

}
