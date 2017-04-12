//
//  LoginNavVC.swift
//  TeamFitnessApp
//
//  Created by Alessandro Musto on 4/12/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class LoginNavVC: UINavigationController {

  override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationBar.isHidden = true
    self.navigationBar.barTintColor = UIColor.white
    self.navigationBar.tintColor = UIColor.foregroundOrange
    self.setViewControllers([LogInViewController()], animated: false)
  }





}
