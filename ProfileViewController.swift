//
//  ProfileView.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/6/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

   
    
    var profileView = FitnessView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProfileViewControllerUI()

        
        
        
    }
    
    func pressSexButton () {
        
        let alertController = UIAlertController(title: "Simple", message: "Simple alertView demo with Cancel and Ok.", preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
            print("Cancel")
        }
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
            print("OK")
        }
        
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        

        self.present(alertController, animated: true)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        super.loadView()
        self.view = profileView
    }

}

extension ProfileViewController {
    
    func loadProfileViewControllerUI() {
       
        let profileLabel = FitnessLabel()
        self.view.addSubview(profileLabel)
        profileLabel.translatesAutoresizingMaskIntoConstraints = false
        profileLabel.textAlignment = NSTextAlignment.center
        profileLabel.reverseColors()
        profileLabel.changeFontSize(to: 32.0)
        profileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        profileLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        profileLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        profileLabel.text = "Profile"
        
        let nameTextField = UITextField()
        self.view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.layer.cornerRadius = 5
        nameTextField.textAlignment = NSTextAlignment.center
        nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameTextField.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 50).isActive = true
        nameTextField.placeholder = "name"
        nameTextField.backgroundColor = UIColor.white
        
        let weightTextField = UITextField()
        self.view.addSubview(weightTextField)
        weightTextField.translatesAutoresizingMaskIntoConstraints = false
        weightTextField.layer.cornerRadius = 5
        weightTextField.textAlignment = NSTextAlignment.center
        weightTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        weightTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        weightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        weightTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 50).isActive = true
        weightTextField.placeholder = "weight"
        weightTextField.backgroundColor = UIColor.white
        
        let sexButton = FitnessButton()
        self.view.addSubview(sexButton)
        sexButton.translatesAutoresizingMaskIntoConstraints = false
        sexButton.setTitle("Sex", for: .normal)
        sexButton.changeFontSize(to: 16.0)
        sexButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        sexButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
        sexButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        sexButton.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 20).isActive = true
        sexButton.addTarget(self, action: #selector(pressSexButton), for: UIControlEvents.touchUpInside)
//
//        let heightFeetTextField = UITextField()
//        self.view.addSubview(heightFeetTextField)
//        heightFeetTextField.translatesAutoresizingMaskIntoConstraints = false
//        heightFeetTextField.layer.cornerRadius = 5
//        heightFeetTextField.textAlignment = NSTextAlignment.center
//        heightFeetTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
//        heightFeetTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
//        heightFeetTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        heightFeetTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 50).isActive = true
//        heightFeetTextField.placeholder = "weight"
//        heightFeetTextField.backgroundColor = UIColor.white
//        
//        let heightInchesTextField = UITextField()
//        self.view.addSubview(heightInchesTextField)
//        heightInchesTextField.translatesAutoresizingMaskIntoConstraints = false
//        heightInchesTextField.layer.cornerRadius = 5
//        heightInchesTextField.textAlignment = NSTextAlignment.center
//        heightInchesTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
//        heightInchesTextField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.05).isActive = true
//        heightInchesTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        heightInchesTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 50).isActive = true
//        heightInchesTextField.placeholder = "weight"
//        heightInchesTextField.backgroundColor = UIColor.white
//
    
    
    
    }
    
    
}
