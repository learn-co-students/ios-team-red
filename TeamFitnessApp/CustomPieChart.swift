//
//  CustomPieChart.swift
//  TeamFitnessApp
//
//  Created by Alessandro Musto on 4/9/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import UIKit
import Charts


class CustomPieChartView: PieChartView {


  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()

  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  func commonInit() {
    self.chartDescription?.text = ""
    self.legend.enabled = false
    self.animate(xAxisDuration: 1.4, easingOption: .easeOutBack)
    self.rotationEnabled = false
    self.highlightPerTapEnabled = false

  }


  func setData(goal: Double, current: Double) {


    var values = [PieChartDataEntry]()

    if current > goal {
      values.append(PieChartDataEntry(value: abs(goal-current), label: "OVER GOAL"))
      values.append(PieChartDataEntry(value: goal.rounded(), label: "GOAL"))
    } else {
      values.append(PieChartDataEntry(value: (goal-current), label: "TO GO"))
      values.append(PieChartDataEntry(value: current, label: "YOU"))
    }


    let dataSet = PieChartDataSet(values: values, label: "")

    dataSet.sliceSpace = 2.0

    let colors = [UIColor.raspberry, UIColor.lagoon]

    dataSet.colors = colors

    let data = PieChartData(dataSet: dataSet)

    let pFormatter = NumberFormatter()
    pFormatter.numberStyle = .none
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = 1
    let descript = UIFontDescriptor(name: "Fresca-Regular", size: 15)
    data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
    data.setValueFont(NSUIFont(descriptor:descript, size:15))
    data.setValueTextColor(UIColor.white)

    self.data = data;
    
  }
}



