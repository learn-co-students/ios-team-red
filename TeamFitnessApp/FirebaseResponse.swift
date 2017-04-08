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
    case successfulNewUser(FIRUser)
    case successfulLogout(String)
    case succesfulUpload(String)
    case failure(String)

    
}
