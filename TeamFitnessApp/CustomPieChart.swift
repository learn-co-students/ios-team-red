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
  }


  func setData(goal: Double, current: Double) {


    var values = [PieChartDataEntry]()

    if current > goal {
      values.append(PieChartDataEntry(value: abs(goal-current), label: "over goal"))
      values.append(PieChartDataEntry(value: goal, label: "goal"))
    } else {
      values.append(PieChartDataEntry(value: goal-current, label: "left"))
      values.append(PieChartDataEntry(value: current, label: "you"))
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



