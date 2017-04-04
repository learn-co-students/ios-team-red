//
//  FirebaseResponse.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/4/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import Firebase

enum FirebaseResponse {
    case successfulLogin(FIRUser)
    case failedLogin(String)
    case successfulNewUser(FIRUser)
    case failedNewUser(String)
    case successfulLogout(String)
    case failedLogout(String)
    
}
