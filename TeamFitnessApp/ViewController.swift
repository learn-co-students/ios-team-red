//
//  ViewController.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/3/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.backgroundBlack
        let frame1 = CGRect(x: 0, y: 0, width: 100, height: 100)
        let button1 = FitnessButton(frame: frame1)
        button1.setTitle("Hey!", for: .normal)
        self.view.addSubview(button1)
        let frame2 = CGRect(x: 0, y: 100, width: 100, height: 100)
        let button2 = FitnessButton(frame: frame2)
        button2.setTitle("Hey!", for: .normal)
        button2.reverseColors()
        self.view.addSubview(button2)
        
        let frame3 = CGRect(x: 0, y: 200, width: 100, height: 100)
        let label1 = FitnessLabel(frame: frame3)
        label1.text = "Hey!"
        self.view.addSubview(label1)
        
        let frame4 = CGRect(x: 0, y: 300, width: 100, height: 100)
        let label2 = FitnessLabel(frame: frame4)
        label2.text = "Hey!"
        label2.reverseColors()
        self.view.addSubview(label2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

