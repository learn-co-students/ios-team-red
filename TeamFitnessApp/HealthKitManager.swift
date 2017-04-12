//
//  HealthKitManager.swift
//  TeamFitnessApp
//
//  Created by Alessandro Musto on 4/4/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import HealthKit

final class HealthKitManager {

  static let sharedInstance = HealthKitManager()
  private init () {}
  fileprivate let healthStore = HKHealthStore()



  //request user authorization to read steps,distance,calories and workoutTime. to write height and weight
  func requestHealthKitAuth(completion: @escaping (Bool) -> ()) {

    let stepsCount = HKQuantityType.quantityType(forIdentifier: .stepCount)
    let distance = HKObjectType.quantityType(forIdentifier: .distanceWalkingRunning)
    let calories = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned)
    let workoutTime = HKObjectType.quantityType(forIdentifier: .appleExerciseTime)

    let weight = HKObjectType.quantityType(forIdentifier: .bodyMass)
    let height = HKObjectType.quantityType(forIdentifier: .height)


    if HKHealthStore.isHealthDataAvailable() {

      guard let weight = weight,
        let height = height,
        let distance = distance,
        let calories = calories,
        let workoutTime = workoutTime,
        let stepsCount = stepsCount else { completion(false); return  }

      healthStore.requestAuthorization(toShare: [weight, height], read: [stepsCount, distance, calories, workoutTime]) { (success, error) in
        if success {
          completion(true)
        } else {
          completion(false)
        }
      }
    }
  }


  //MARK: - Read Data from HealthKit
  //get total steps between two dates
  func getSteps(fromDate startDate: Date, toDate endDate: Date?, completion: @escaping (Double?, Error?) -> ()) {
    //If no endDate provided, make endDate now
    let now: Date!
    if endDate != nil {
      now = endDate
    } else {
      now = Date()
    }

    let past = startDate

    var interval = DateComponents()
    interval.day = 1

    if let sampleType = HKQuantityType.quantityType(forIdentifier: .stepCount) {

      let stepsQuery = HKStatisticsCollectionQuery(quantityType: sampleType, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: past, intervalComponents: interval)

      stepsQuery.initialResultsHandler = { query, results, error in
          if error != nil {
            print(error!.localizedDescription)
            completion(nil, error)
          }
          let calendarSince = Calendar.current
          let components = calendarSince.dateComponents([Calendar.Component.day, .hour], from: past, to: now)
          var steps = 0.0
          guard let day = components.day, let hour = components.hour else { return }
          let hours = (day * 24) + hour
          if let startDate = calendarSince.date(byAdding: .hour, value: -hours, to: now) {

            if let myResults = results {
              myResults.enumerateStatistics(from: startDate, to: now, with: { (statistics, stop) in
                if let quantity = statistics.sumQuantity() {
                  steps += quantity.doubleValue(for: HKUnit.count())
                }
              })
            }
            completion(steps, nil)
          }
        }
      healthStore.execute(stepsQuery)
    }
  }

  //Get distance in miles between two dates
  func getDistance(fromDate startDate: Date, toDate endDate: Date?, completion: @escaping (Double?, Error?) -> ()) {
    //If no endDate provided, make endDate now
    let now: Date!
    if endDate != nil {
      now = endDate
    } else {
      now = Date()
    }

    let past = startDate

    var interval = DateComponents()
    interval.day = 1

    if let sampleType = HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning) {

      let distanceQuery = HKStatisticsCollectionQuery(quantityType: sampleType, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: past, intervalComponents: interval)

      distanceQuery.initialResultsHandler = { query, results, error in
          if error != nil {
            print(error!.localizedDescription)
            completion(nil, error)
          }
          let calendarSince = Calendar.current
          let components = calendarSince.dateComponents([Calendar.Component.day, .hour], from: past, to: now)
          var distance = 0.0
          guard let day = components.day, let hour = components.hour else { return }
          let hours = (day * 24) + hour
          if let startDate = calendarSince.date(byAdding: .hour, value: -hours, to: now) {

            if let myResults = results {
              myResults.enumerateStatistics(from: startDate, to: now, with: { (statistics, stop) in
                if let quantity = statistics.sumQuantity() {
                  distance += quantity.doubleValue(for: HKUnit.mile())
                }
              })
            }
            completion(distance, nil)
          }
        }
      healthStore.execute(distanceQuery)
    }
  }

  //get calories between two dates
  func getCalories(fromDate startDate: Date, toDate endDate: Date?, completion: @escaping (Double?, Error?) -> ()) {
    //If no endDate provided, make endDate now
    let now: Date!
    if endDate != nil {
      now = endDate
    } else {
      now = Date()
    }

    let past = startDate

    var interval = DateComponents()
    interval.day = 1

    if let sampleType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) {

      let calorieQuery = HKStatisticsCollectionQuery(quantityType: sampleType, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: past, intervalComponents: interval)

      calorieQuery.initialResultsHandler = { query, results, error in
          if error != nil {
            print(error!.localizedDescription)
            completion(nil, error)
          }
          let calendarSince = Calendar.current
          let components = calendarSince.dateComponents([Calendar.Component.day, .hour], from: past, to: now)
          var calories = 0.0
          guard let day = components.day, let hour = components.hour else { return }
          let hours = (day * 24) + hour
          if let startDate = calendarSince.date(byAdding: .hour, value: -hours, to: now) {

            if let myResults = results {
              myResults.enumerateStatistics(from: startDate, to: now, with: { (statistics, stop) in
                if let quantity = statistics.sumQuantity() {
                  calories += (quantity.doubleValue(for: HKUnit.calorie()))/1000
                }
              })
            }
            completion(calories, nil)
          }
        }
      healthStore.execute(calorieQuery)
    }
  }

  //Get exercise time in minutes between to dates
  func getExerciseTime(fromDate startDate: Date, toDate endDate: Date?, completion: @escaping (Double?, Error?) -> ()) {
    //If no endDate provided, make endDate now
    let now: Date!
    if endDate != nil {
      now = endDate
    } else {
      now = Date()
    }

    let past = startDate

    var interval = DateComponents()
    interval.day = 1

    if let sampleType = HKQuantityType.quantityType(forIdentifier: .appleExerciseTime) {

      let exerciseQuery = HKStatisticsCollectionQuery(quantityType: sampleType, quantitySamplePredicate: nil, options: .cumulativeSum, anchorDate: past, intervalComponents: interval)

      exerciseQuery.initialResultsHandler = { query, results, error in
          if error != nil {
            print(error!.localizedDescription)
            completion(nil, error)
          }
          let calendarSince = Calendar.current
          let components = calendarSince.dateComponents([Calendar.Component.day, .hour], from: past, to: now)
          var exerciseTime = 0.0
          guard let day = components.day, let hour = components.hour else { return }
          let hours = (day * 24) + hour
          if let startDate = calendarSince.date(byAdding: .hour, value: -hours, to: now) {

            if let myResults = results {
              myResults.enumerateStatistics(from: startDate, to: now, with: { (statistics, stop) in
                if let quantity = statistics.sumQuantity() {
                  exerciseTime += quantity.doubleValue(for: HKUnit.minute())
                }
              })
            }
            completion(exerciseTime, nil)
          }
        }
      healthStore.execute(exerciseQuery)
    }
  }


  //MARK: - Write to HealthKit
  //Send Weight in lbs.
  func sendWeightToHealthKit(weight: Double, completion: @escaping (Bool) -> ()) {
    let date = Date()
    let weightQuantity = HKQuantity(unit: HKUnit.pound(), doubleValue: weight)
    if let weightType = HKQuantityType.quantityType(forIdentifier: .bodyMass) {
      let weightSample = HKQuantitySample(type: weightType, quantity: weightQuantity, start: date, end: date)

      healthStore.save(weightSample) { (success, error) in
        if error != nil {
          print(error!.localizedDescription)
          completion(false)
        } else {
          completion(true)
        }
      }
    }
  }

  //Send Height in inches
  func sendHeightToHealthKit(height: Double, completion: @escaping (Bool) -> ()) {
    let date = Date()
    let heightQuantity = HKQuantity(unit: HKUnit.inch(), doubleValue: height)
    if let heightType = HKQuantityType.quantityType(forIdentifier: .height) {
      let heightSample = HKQuantitySample(type: heightType, quantity: heightQuantity, start: date, end: date)

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
}
