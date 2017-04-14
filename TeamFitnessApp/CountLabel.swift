//
//  CountLabel.swift
//  TeamFitnessApp
//
//  Created by Alessandro Musto on 4/13/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class CountLabel: UILabel {


  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  func commonInit() {
    self.textColor = UIColor.black
    self.backgroundColor = UIColor.white
    self.layer.cornerRadius = 8
    self.layer.borderWidth = 2
    self.layer.borderColor = UIColor.black.cgColor
    self.layer.masksToBounds = true
    self.textAlignment = .center
    self.font = UIFont(name: "Gurmukhi MN", size: 17.0)


  }



}
