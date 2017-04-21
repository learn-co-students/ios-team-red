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

    let dashboardVC = NavigationController(rootViewController: DashboardVC())
    dashboardVC.tabBarItem.title = "DAILY CHALLENGES"
    dashboardVC.tabBarItem.image = #imageLiteral(resourceName: "dashboard")
    dashboardVC.tabBarItem.badgeColor = UIColor.whitewash
    let challengesVC = NavigationController(rootViewController: ChallengesVC())
    challengesVC.tabBarItem.title = "GROUP CHALLENGES"
    challengesVC.tabBarItem.image = #imageLiteral(resourceName: "groups")
    let teamVC = NavigationController(rootViewController: TeamsVC())
    teamVC.tabBarItem.title = "TEAMS"
    teamVC.tabBarItem.image = #imageLiteral(resourceName: "peopleWhite")
    let trophyVC = NavigationController(rootViewController: TrophyVC())
    trophyVC.tabBarItem.title = "TROPHIES"
    trophyVC.tabBarItem.image = #imageLiteral(resourceName: "trophyWhite")
    self.setViewControllers([dashboardVC, challengesVC, teamVC, trophyVC], animated: false)


    let imageArray = [#imageLiteral(resourceName: "dashboard"), #imageLiteral(resourceName: "groups"), #imageLiteral(resourceName: "peopleWhite"), #imageLiteral(resourceName: "trophyWhite")]

    if let count = self.tabBar.items?.count {
      for i in 0...(count-1) {
        let imageNameForSelectedState   = imageArray[i]
        let imageNameForUnselectedState = imageArray[i]

//        self.tabBar.items?[i].selectedImage = imageNameForSelectedState.withRenderingMode(.alwaysOriginal)
        self.tabBar.items?[i].image = imageNameForUnselectedState.withRenderingMode(.alwaysOriginal)
      }


      let selectedColor   = UIColor.raspberry
      let unselectedColor = UIColor.whitewash

      self.tabBar.tintColor = selectedColor

      let attributesNormal: NSDictionary = [
        NSFontAttributeName:UIFont(name: "Fresca-Regular", size: 12)!,
        NSKernAttributeName:CGFloat(3.0),
        NSForegroundColorAttributeName: unselectedColor
      ]

      let attributesSelected: NSDictionary = [
        NSFontAttributeName:UIFont(name: "Fresca-Regular", size: 12)!,
        NSKernAttributeName:CGFloat(3.0),
        NSForegroundColorAttributeName: selectedColor
      ]


      UITabBarItem.appearance().setTitleTextAttributes(attributesNormal as! [String : Any], for: .normal)
      UITabBarItem.appearance().setTitleTextAttributes(attributesSelected as! [String : Any], for: .selected)
    }



    }





  func setAttributes(text: String) {

  }





}
