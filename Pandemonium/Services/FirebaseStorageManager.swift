//
//  FirebaseStorageManager.swift
//  Pandemonium
//
//  Created by Reiaz Gafar on 2/7/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseDatabase

enum ImageType {
    case user
    case post
}

class FirebaseStorageManager {
    private init(){
        storage = Storage.storage()
        storageRef = storage.reference()
        imagesRef = storageRef.child("images")
    }
    static let shared = FirebaseStorageManager()
    
    private var storage: Storage!
    private var storageRef: StorageReference!
    private var imagesRef: StorageReference!
    
    func storeImage(type: ImageType, uid: String, image: UIImage) {
        guard let data = UIImagePNGRepresentation(image) else { print("image is nil"); return }
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        let uploadTask = FirebaseStorageManager.shared.imagesRef.child(uid).putData(data, metadata: metadata) { (storageMetadata, error) in
            if let error = error {
                print("uploadTask error: \(error)")
            } else if let storageMetadata = storageMetadata {
                print("storageMetadata: \(storageMetadata)")
            }
        }
        
        // Listen for state changes, errors, and completion of the upload.
        uploadTask.observe(.resume) { snapshot in
            // Upload resumed, also fires when the upload starts
        }
        
        uploadTask.observe(.pause) { snapshot in
            // Upload paused
        }
        
        uploadTask.observe(.progress) { snapshot in
            // Upload reported progress
            let percentProgress = 100.0 * Double(snapshot.progress!.completedUnitCount)
                / Double(snapshot.progress!.totalUnitCount)
            print(percentProgress)
        }
        
        uploadTask.observe(.success) { snapshot in
            // Upload completed successfully
            
            // set job's imageURL
            let imageURL = String(describing: snapshot.metadata!.downloadURL()!)

            switch type {
            case .user:
                Database.database().reference(withPath: "users").child(uid).child("image").setValue(imageURL)
            case .post:
                Database.database().reference(withPath: "posts").child(uid).child("image").setValue(imageURL)
            }
            
        }
        
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as NSError? {
                switch (StorageErrorCode(rawValue: error.code)!) {
                case .objectNotFound:
                    // File doesn't exist
                    break
                case .unauthorized:
                    // User doesn't have permission to access file
                    break
                case .cancelled:
                    // User canceled the upload
                    break
                    
                    /* ... */
                    
                case .unknown:
                    // Unknown error occurred, inspect the server response
                    break
                default:
                    // A separate error occurred. This is a good place to retry the upload.
                    break
                }
            }
        }
    }
    
    func retrieveImage(imgURL: String,
                       completionHandler: @escaping (UIImage) -> Void,
                       errorHandler: @escaping (Error) -> Void) {
        
        
        ImageHelper.manager.getImage(from: imgURL, completionHandler: { completionHandler($0) }, errorHandler: { errorHandler($0) })
        
        
//        let ref = storageRef.child(img)
//        ref.getData(maxSize: 1 * 1024 * 1024) { (data, error) in
//            if let error = error {
//                print()
//                print("ERROR GETTING IMAGE DATA")
//                print()
//                errorHandler(error)
//            } else if let data = data {
//                if let image = UIImage(data: data) {
//                    completionHandler(image)
//                }
//            }
//        }

    }
    
    
}
