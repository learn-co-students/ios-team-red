//
//  CustomHorizontalBarChart.swift
//  HK
//
//  Created by Alessandro Musto on 4/9/17.
//  Copyright © 2017 Lmusto. All rights reserved.
//

import Foundation
import Charts

class CustomHorizontalBarChart: HorizontalBarChartView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  func commonInit() {
    self.drawBarShadowEnabled = false
    self.drawValueAboveBarEnabled = true

    self.chartDescription?.text = ""
    self.legend.enabled = false

    self.highlighter = nil


    self.scaleYEnabled = false
    self.scaleXEnabled = false
    self.pinchZoomEnabled = false
    self.doubleTapToZoomEnabled = false

    let yAxis = self.rightAxis
    yAxis.axisLineColor = UIColor.raspberry
    yAxis.labelTextColor = UIColor.raspberry
    yAxis.gridColor = UIColor.raspberry



    self.extraBottomOffset = 10
    let xAxis = self.xAxis
    xAxis.enabled = true
    xAxis.drawAxisLineEnabled = true
    xAxis.drawGridLinesEnabled = false
    xAxis.axisLineColor = UIColor.raspberry
    xAxis.labelTextColor = UIColor.raspberry
    xAxis.labelPosition = .bottom
    xAxis.granularity = 1
    xAxis.labelFont = UIFont(name: "Fresca-Regular", size: 15.0)!

    let leftAxis = self.leftAxis
    leftAxis.enabled = false
    leftAxis.axisMinimum = 0

    self.fitBars = true

    self.animate(yAxisDuration: 2.5)
  }

  func setData(group: [(String, Double)]) {
    let sortedGroup = group.sorted { $0.1 < $1.1 }

    var values = [Double]()
    var names = [String]()
    for (name, value) in sortedGroup {
      values.append(value)
      names.append(name)
    }

    self.setChartData(xValues: names, yValues: values, label: "")
    self.xAxis.avoidFirstLastClippingEnabled = true
  }
}


extension CustomHorizontalBarChart {


  private class BarChartFormatter: NSObject, IAxisValueFormatter {

    var labels: [String] = []

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
      return labels[Int(value)]
    }

    init(labels: [String]) {
      super.init()
      self.labels = labels
    }
  }

  fileprivate func setChartData(xValues: [String], yValues: [Double], label: String) {

    var dataEntries: [BarChartDataEntry] = []

    for i in 0..<yValues.count {
      let dataEntry = BarChartDataEntry(x: Double(i), y: yValues[i])
      dataEntries.append(dataEntry)
    }

    let chartDataSet = BarChartDataSet(values: dataEntries, label: label)
    let chartData = BarChartData(dataSet: chartDataSet)
    chartDataSet.colors = [UIColor.raspberry]
    chartDataSet.valueColors = [UIColor.raspberry]

    let chartFormatter = BarChartFormatter(labels: xValues)
    let xAxis = XAxis()
    xAxis.valueFormatter = chartFormatter
    self.xAxis.valueFormatter = xAxis.valueFormatter

    self.data = chartData
  }
}
