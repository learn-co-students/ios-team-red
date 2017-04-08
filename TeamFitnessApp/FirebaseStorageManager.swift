//
//  FirebaseStorageManager.swift
//  TeamFitnessApp
//
//  Created by Patrick O'Leary on 4/8/17.
//  Copyright © 2017 Patrick O'Leary. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage

struct FirebaseStoreageManager {

    private static let storage = FIRStorage.storage()
    private static let storageRef = FIRStorage.storage().reference()
    private static let teamImagesRef = FIRStorage.storage().reference().child("teamImages")
    private static let userImageRef = FIRStorage.storage().reference().child("userImages")
    
    static func upload(teamImage: UIImage, withTeamID teamID: String, completion: @escaping (FirebaseResponse) -> Void) {
        if let imageData: Data = UIImagePNGRepresentation(teamImage) {
            let imageRef = teamImagesRef.child("\(teamID).png")
            _ = imageRef.put(imageData, metadata: nil, completion: { (metadata, error) in
                if metadata != nil {
                    completion(.succesfulUpload("Uploaded team image to path teamImages/\(teamID).png"))
                } else {
                    completion(.failure("Could not upload image to Firebase"))
                }
            })
        } else {
            //TODO: - handle error - could not convert image to data
        }
    }
}
