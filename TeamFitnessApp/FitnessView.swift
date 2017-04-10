//
//  FitnessView.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/4/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class FitnessView: UIView {

    var images = [UIImage]()
    var titleLabel = FitnessLabel()
    let sportImageView = UIImageView()

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
//    init() {
//        super.init(frame: CGRect.zero)
//        commonInit()
//    }
    
    

    
    func commonInit() {
        self.backgroundColor = UIColor.backgroundBlack
        //sportImageView.contentMode = .scaleAspectFit
        setupImage()
        
    }
    
    func setupImage() {
        self.addSubview(sportImageView)
        sportImageView.translatesAutoresizingMaskIntoConstraints = false
        sportImageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        sportImageView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        sportImageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        sportImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        images = [#imageLiteral(resourceName: "runner1"), #imageLiteral(resourceName: "runner2"), #imageLiteral(resourceName: "soccer")]
        let randomNum = Int(arc4random_uniform(2))
        let image = images[randomNum]
        sportImageView.image = image
    }
}
