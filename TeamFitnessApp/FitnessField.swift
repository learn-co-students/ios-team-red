//
//  FitnessField.swift
//  TeamFitnessApp
//
//  Created by Alessandro Musto on 4/19/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class FitnessField: UITextField {


  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }



  func commonInit() {

    let attributes: NSDictionary = [
      NSFontAttributeName:UIFont(name: "Fresca-Regular", size: 17)!,
      NSKernAttributeName:CGFloat(3.0),
      NSForegroundColorAttributeName:UIColor.black,
      ]

    self.defaultTextAttributes = attributes as! [String : Any]

    self.backgroundColor = UIColor.reallyLightGray
    self.layer.cornerRadius = 5
    self.textAlignment = NSTextAlignment.center

  }


  func setPlaceholder(text: String) {
    let attributes: NSDictionary = [
      NSFontAttributeName:UIFont(name: "Fresca-Regular", size: 17)!,
      NSKernAttributeName:CGFloat(3.0),
      NSForegroundColorAttributeName:UIColor.lightGray,
      ]

    self.attributedPlaceholder = NSAttributedString(string: text.uppercased(), attributes:attributes as? [String : AnyObject])

  }

}


extension UISearchBar {

    private func getViewElement<T>(type: T.Type) -> T? {

        let svs = subviews.flatMap { $0.subviews }
        guard let element = (svs.filter { $0 is T }).first as? T else { return nil }
        return element
    }

    func getSearchBarTextField() -> UITextField? {

        return getViewElement(type: UITextField.self)
    }

    func setTextAttributes() {
        let attributes: NSDictionary = [
            NSFontAttributeName:UIFont(name: "Fresca-Regular", size: 15)!,
            NSKernAttributeName:CGFloat(3.0),
            NSForegroundColorAttributeName:UIColor.black,
            ]
        if let textField = getSearchBarTextField() {
            textField.defaultTextAttributes = attributes as! [String: Any]
        }

    }


    func setPlaceholderAttributes() {
        let attributes: NSDictionary = [
            NSFontAttributeName:UIFont(name: "Fresca-Regular", size: 15)!,
            NSKernAttributeName:CGFloat(3.0),
            NSForegroundColorAttributeName:UIColor.lightGray,
            ]

        if let textField = getSearchBarTextField() {
            textField.attributedPlaceholder = NSAttributedString(string: self.placeholder != nil ? self.placeholder!.uppercased() : "", attributes:attributes as? [String : AnyObject])
        }
    }
}

