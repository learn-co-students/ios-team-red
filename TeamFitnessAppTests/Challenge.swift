//
//  Challenge.swift
//  TeamFitnessApp
//
//  Created by Lawrence Herman on 4/4/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation


struct Challenge {
    
    var startDate: Date
    var endDate: Date
    var goal: Goal
    var creator: String
    var userUIDs: [String]
    var isPublic: Bool
    var team: Team?
    var id: String
    
}
