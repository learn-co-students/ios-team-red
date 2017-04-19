//
//  FitnessButton.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/4/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class FitnessButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    func commonInit() {
        self.titleLabel?.font = UIFont(name: "Fresca-Regular", size: 17.0)
        self.setTitleColor(UIColor.whitewash, for: .normal)
        self.backgroundColor = UIColor.lagoon
        self.layer.cornerRadius = 5
    }
    
    func reverseColors() {
        self.setTitleColor(UIColor.lagoon, for: .normal)
        self.backgroundColor = UIColor.clear
    }
    
    func changeFontSize(to newFontSize: CGFloat) {
        self.titleLabel?.font = UIFont(name: "Fresca-Regular", size: newFontSize)
    }

  func set(text: String) {
    let attributes: NSDictionary = [
      NSFontAttributeName:UIFont(name: "Fresca-Regular", size: 17)!,
      NSKernAttributeName:CGFloat(3.0),
      NSForegroundColorAttributeName:UIColor.whitewash,
    ]
    let attributedTitle = NSAttributedString(string: text.uppercased(), attributes:attributes as? [String : AnyObject])

    self.setAttributedTitle(attributedTitle, for: .normal)
  }

  func setReversed(text: String) {
    let attributes: NSDictionary = [
      NSFontAttributeName:UIFont(name: "Fresca-Regular", size: 13)!,
      NSKernAttributeName:CGFloat(3.0),
      NSForegroundColorAttributeName:UIColor.lagoon,
      NSBackgroundColorAttributeName:UIColor.clear

    ]
    let attributedTitle = NSAttributedString(string: text.uppercased(), attributes:attributes as? [String : AnyObject])

    self.setAttributedTitle(attributedTitle, for: .normal)
  }
}
