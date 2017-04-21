//
//  DashboardView.swift
//  TeamFitnessApp
//
//  Created by Alessandro Musto on 4/9/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import UIKit
import Charts
import HealthKit


class DashboardView: FitnessView {

  let healhKitManager = HealthKitManager.sharedInstance
  var user: User! {
    didSet {
      pieOneLabel.set(text: "exercise time")
        pieOneLabel.changeFontSize(to: 20)
      pieTwoLabel.set(text: "calories burned")
        pieTwoLabel.changeFontSize(to: 20)
      goalOne = user.goals[1].value
      goalTwo = user.goals[0].value
      grabHealtKit()
    }
  }
  var goalOne: Double!
  var goalTwo: Double!
  var pieChartView1: CustomPieChartView!
  var pieOneLabel: TitleLabel!
  var pieChartView2: CustomPieChartView!
  var pieTwoLabel: TitleLabel!

  override init(frame: CGRect) {
    super.init(frame: frame)
    comInit()
    setConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    comInit()
    setConstraints()
  }



  func comInit() {
    pieChartView1 = CustomPieChartView(frame: CGRect.zero)
    pieChartView1.backgroundColor = UIColor.clear
    pieChartView1.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(pieChartView1)

    pieOneLabel = TitleLabel(frame: CGRect.zero)
    pieOneLabel.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(pieOneLabel)

    
    pieChartView2 = CustomPieChartView(frame: CGRect.zero)
    pieChartView2.backgroundColor = UIColor.clear
    pieChartView2.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(pieChartView2)

    pieTwoLabel = TitleLabel(frame: CGRect.zero)
    pieTwoLabel.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(pieTwoLabel)

  }

  func setConstraints() {
    pieOneLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 75).isActive = true
    pieOneLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    pieOneLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    pieOneLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true

    pieChartView1.topAnchor.constraint(equalTo: pieOneLabel.bottomAnchor, constant: 5).isActive = true
    pieChartView1.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    pieChartView1.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
    pieChartView1.heightAnchor.constraint(equalToConstant: 175).isActive = true


    pieTwoLabel.topAnchor.constraint(equalTo: pieChartView1.bottomAnchor, constant: 20).isActive = true
    pieTwoLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    pieTwoLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    pieTwoLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true

    pieChartView2.topAnchor.constraint(equalTo: pieTwoLabel.bottomAnchor, constant: 5).isActive = true
    pieChartView2.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    pieChartView2.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20).isActive = true
    pieChartView2.heightAnchor.constraint(equalToConstant: 175).isActive = true

  }

  func grabHealtKit() {
    var calendar = NSCalendar.current
    calendar.timeZone = NSTimeZone.local
    let dateAtMidnight = calendar.startOfDay(for: Date())
    healhKitManager.getCalories(fromDate: dateAtMidnight, toDate: Date()) { (calories, error) in
      if let calories = calories {
        DispatchQueue.main.async {
          self.pieChartView2.setData(goal: self.goalTwo, current: calories)
        }
      }
    }

    healhKitManager.getExerciseTime(fromDate: dateAtMidnight, toDate: Date()) { (time, error) in
      if let time = time {
        DispatchQueue.main.async {
          self.pieChartView1.setData(goal: self.goalOne, current: time)
        }
      }
    }
  }
}

