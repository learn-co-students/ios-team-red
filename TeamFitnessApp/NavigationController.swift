//
//  NavigationController.swift
//  TeamFitnessApp
//
//  Created by Alessandro Musto on 4/11/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.barTintColor = UIColor.lagoon
        self.navigationBar.tintColor = UIColor.whitewash
    }

}


extension UINavigationItem {

    func setTitle(text: String) {
        let titleLabel = FitnessLabel(frame: CGRect(x:0, y:0, width: 150, height: 45))
        titleLabel.set(text: text)
        titleLabel.textColor = UIColor.whitewash
        self.titleView = titleLabel
    }
}
