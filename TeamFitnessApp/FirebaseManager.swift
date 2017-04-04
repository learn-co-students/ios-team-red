//
//  FirebaseManager.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/4/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import Firebase

struct FirebaseManager {
    
    var dataRef: FIRDatabaseReference = FIRDatabase.database().reference()
    
    static func createNewUser(withEmail email: String, andPassword password: String) {
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            
        })
    }
    
    
}
