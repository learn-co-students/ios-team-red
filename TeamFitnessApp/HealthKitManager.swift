//
//  HealthKitManager.swift
//  TeamFitnessApp
//
//  Created by Alessandro Musto on 4/4/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import HealthKit

final class HealthKidManager {

  static let sharedInstance = HealthKidManager()
  private init () {}
  fileprivate let healthStore = HKHealthStore()



  //request user authorization
   func requestHealthKitAuth() -> Bool {

    var isEnabled = true

    let stepsCount = HKQuantityType.quantityType(forIdentifier: .stepCount)!
    let activitySummary = HKObjectType.activitySummaryType()
    let distance = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)

    let weight = HKObjectType.quantityType(forIdentifier: .bodyMass)
    let height = HKObjectType.quantityType(forIdentifier: .height)


    if HKHealthStore.isHealthDataAvailable() {

      healthStore.requestAuthorization(toShare: [weight!, height!], read: [stepsCount, activitySummary, distance!]) { (success, error) in
        if success {
          isEnabled = true
        } else {
          isEnabled = false
        }
      }
    }
    return isEnabled
  }


  //MARK: - Read Data from HealthKit

  func getSteps(fromDate startDate: Date, toDate endDate: Date?, completion: @escaping (Double?, Error?) -> ()) {
    let now: Date!
    if endDate != nil {
      now = endDate
    } else {
      now = Date()
    }

    let past = startDate

    var interval = DateComponents()
    interval.day = 1

    let sampleType = HKQuantityType.quantityType(forIdentifier: .stepCount)

    let stepsQuery = HKStatisticsCollectionQuery(quantityType: sampleType!, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: past, intervalComponents: interval)

    stepsQuery.initialResultsHandler = { query, results, error in
      DispatchQueue.main.async {
        if error != nil {
          print(error!.localizedDescription)
          completion(nil, error)
        }
        let calendarSince = Calendar.current
        let components = calendarSince.dateComponents([Calendar.Component.day, .hour], from: past, to: now)
        var steps = 0.0
        let hours = (components.day! * 24) + components.hour!
        let startDate = calendarSince.date(byAdding: .hour, value: -hours, to: now)

        if let myResults = results { myResults.enumerateStatistics(from: startDate!, to: now, with: { (statistics, stop) in
          if let quantity = statistics.sumQuantity() {
            steps += quantity.doubleValue(for: HKUnit.count())
          }
        })
          completion(steps, nil)
        }
      }
    }
    healthStore.execute(stepsQuery)
  }


  func getDistance(fromDate startDate: Date, toDate endDate: Date?, completion: @escaping (Double?, Error?) -> ()) {
    let now: Date!
    if endDate != nil {
      now = endDate
    } else {
      now = Date()
    }

    let past = startDate

    var interval = DateComponents()
    interval.day = 1

    let sampleType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)

    let distanceQuery = HKStatisticsCollectionQuery(quantityType: sampleType!, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: past, intervalComponents: interval)

    distanceQuery.initialResultsHandler = { query, results, error in
      DispatchQueue.main.async {
        if error != nil {
          print(error!.localizedDescription)
          completion(nil, error)
        }
        let calendarSince = Calendar.current
        let components = calendarSince.dateComponents([Calendar.Component.day, .hour], from: past, to: now)
        var distance = 0.0
        let hours = (components.day! * 24) + components.hour!
        let startDate = calendarSince.date(byAdding: .hour, value: -hours, to: now)

        if let myResults = results { myResults.enumerateStatistics(from: startDate!, to: now, with: { (statistics, stop) in
          if let quantity = statistics.sumQuantity() {
            distance += quantity.doubleValue(for: HKUnit.mile())
          }
        })
          completion(distance, nil)
        }
      }
    }
    healthStore.execute(distanceQuery)
  }


  //MARK: - Write to HealthKit
  func sendWeightToHealthKit(weight: Double, completion: @escaping (Bool) -> ()) {
    let date = Date()
    let weightType = HKQuantityType.quantityType(forIdentifier: .bodyMass)
    let weightQuantity = HKQuantity(unit: HKUnit.pound(), doubleValue: weight)
    let weightSample = HKQuantitySample(type: weightType!, quantity: weightQuantity, start: date, end: date)

    healthStore.save(weightSample) { (success, error) in
      if error != nil {
        print(error!.localizedDescription)
        completion(false)
      } else {
        completion(true)
      }
    }
  }

  func sendHeightToHealthKit(height: Double, completion: @escaping (Bool) -> ()) {
    let date = Date()
    let heightType = HKQuantityType.quantityType(forIdentifier: .height)
    let heightQuantity = HKQuantity(unit: HKUnit.inch(), doubleValue: height)
    let heightSample = HKQuantitySample(type: heightType!, quantity: heightQuantity, start: date, end: date)

    healthStore.save(heightSample) { (success, error) in
      if error != nil {
        print(error!.localizedDescription)
        completion(false)
      } else {
        completion(true)
      }
    }
  }






}
