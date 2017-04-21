//
//  ForgotPasswordVC.swift
//  TeamFitnessApp
//
//  Created by Alessandro Musto on 4/20/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    var emailField: FitnessField!
    var resetButton: FitnessButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setTitle(text: "reset password")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(onCancel(_:)))

        self.view.backgroundColor = UIColor.whitewash


        emailField = FitnessField()
        self.view.addSubview(emailField)
        emailField.setPlaceholder(text: "enter email")
        emailField.autocorrectionType = .no
        emailField.autocapitalizationType = .none
        emailField.translatesAutoresizingMaskIntoConstraints = false

        resetButton = FitnessButton()
        self.view.addSubview(resetButton)
        resetButton.set(text: "reset password")
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.addTarget(self, action: #selector(resetPressed(_:)), for: .touchUpInside)

        setConstraints()



    }

    func setConstraints() {

        emailField.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150).isActive = true
        emailField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.75).isActive = true
        emailField.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.06).isActive = true
        emailField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        resetButton.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 50).isActive = true
        resetButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.50).isActive = true
        resetButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.15).isActive = true
        resetButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

    }


    func resetPressed(_ sender: UIButton) {
        if let text = emailField.text {
            FirebaseManager.resetPassword(forEmail: text, completion: { (success, error) in
                if success {

                    let alertVC = UIAlertController(title: "", message: "Reset email sent to \(text)", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                        self.dismiss(animated: true, completion: nil)
                    })
                    alertVC.addAction(okAction)
                    self.present(alertVC, animated: true, completion: nil)

                } else {
                    self.alert(message: error!.localizedDescription)
                }
            })
        }
    }


    func onCancel(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

}
