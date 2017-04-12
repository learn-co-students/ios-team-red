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
      values.append(PieChartDataEntry(value: abs(goal-current).rounded(), label: "over goal"))
      values.append(PieChartDataEntry(value: goal.rounded(), label: "goal"))
    } else {
      values.append(PieChartDataEntry(value: (goal-current).rounded(), label: "left"))
      values.append(PieChartDataEntry(value: current.rounded(), label: "you"))
    }


    let dataSet = PieChartDataSet(values: values, label: "")

    dataSet.sliceSpace = 2.0

    let colors = ChartColorTemplates.colorful()

    dataSet.colors = colors

    let data = PieChartData(dataSet: dataSet)

    let pFormatter = NumberFormatter()
    pFormatter.numberStyle = .none
    pFormatter.maximumFractionDigits = 1;
    pFormatter.multiplier = 1
    let descript = UIFontDescriptor(name: "HelveticaNeue-Light", size: 11)
    data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
    data.setValueFont(NSUIFont(descriptor:descript, size:11))
    data.setValueTextColor(UIColor.white)

    self.data = data;
    
  }
}



