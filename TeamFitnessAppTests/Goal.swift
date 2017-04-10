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

}

