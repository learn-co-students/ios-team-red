//
//  FirebaseResponse.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/4/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import Firebase
import UIKit

enum FirebaseResponse {

    case successfulLogin(FIRUser)
    case successfulNewUser(String)
    case successfulLogout(String)
    case succesfulUpload(String)
    case successfulDownload(UIImage)
    case successfulData(Double)
    case failure(String)


}
