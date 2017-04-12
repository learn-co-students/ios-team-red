//
//  Goal.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/5/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation



enum GoalType: String {
    case distance, stepCount, caloriesBurned, exerciseTime
}


struct Goal {
  var type: GoalType!
  var value: Double!

  init(type: GoalType, value: Double) {
    self.type = type
    self.value = value
  }
    
    mutating func setType(from str: String) {
        switch str {
            case "distance":
            self.type = .distance
            case "stepCount":
            self.type = .stepCount
            case "caloriesBurned":
            self.type = .caloriesBurned
            case "exerciseTime":
            self.type = .exerciseTime
        default:
            print("Could not get goal type from String") //TODO: - come up with a better way to handle this error
        }
    }
    
    mutating func setValue(from num: Double) {
        self.value = num
    }

}

