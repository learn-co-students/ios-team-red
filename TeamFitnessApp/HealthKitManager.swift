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


  //TODO: make methods to get healthkit data, make mehtods to write to healthkit




}
