//
//  TabBarController.swift
//  TeamFitnessApp
//
//  Created by Alessandro Musto on 4/11/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
      setup()

    }



  func setup() {
    self.tabBar.barTintColor = UIColor.lagoon
    self.tabBar.tintColor = UIColor.whitewash

    let dashboardVC = NavigationController(rootViewController: DashboardVC())
    dashboardVC.tabBarItem.title = "Dashboard"
    dashboardVC.tabBarItem.image = #imageLiteral(resourceName: "dashboard")
    let teamVC = NavigationController(rootViewController: TeamsVC())
    teamVC.tabBarItem.title = "Teams"
    teamVC.tabBarItem.image = #imageLiteral(resourceName: "people")
    let trophyVC = NavigationController(rootViewController: TrophyVC())
    trophyVC.tabBarItem.title = "Trophies"
    trophyVC.tabBarItem.image = #imageLiteral(resourceName: "trophy")
    self.setViewControllers([dashboardVC, teamVC, trophyVC], animated: false)
    }





}
