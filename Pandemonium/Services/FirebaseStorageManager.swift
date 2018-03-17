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
        // Get a reference to the storage service using the default Firebase App
        storage = Storage.storage()
        // Create a storage reference from our storage service
        storageRef = storage.reference()
        // Create a child reference
        imagesRef = storageRef.child("images")
    }
    static let shared = FirebaseStorageManager()
    
    private var storage: Storage!
    private var storageRef: StorageReference!
    private var imagesRef: StorageReference!
    
    
    //Add File Metadata
    func storeImage(type: ImageType, uid: String, image: UIImage) {
        //convert image to png: best practices
        guard let data = UIImagePNGRepresentation(image) else { print("image is nil"); return }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/png" //MUST HAVE THIS TO STORE
        
        //takes an NSData object and returns an FIRStorageUploadTask, which you can use to manage your upload and monitor its status.
        let uploadTask = FirebaseStorageManager.shared.imagesRef.child(uid).putData(data, metadata: metadata) { (storageMetadata, error) in
            if let error = error {
                print("uploadTask error: \(error)")
            } else if let storageMetadata = storageMetadata {
                print("storageMetadata: \(storageMetadata)")
                //there are alot of properties on storageMetaData!!
            }
        }
        
        // Listen for state changes, errors, and completion of the upload.
        uploadTask.observe(.resume) { snapshot in
            // Upload resumed, also fires when the upload starts
        }
        
        uploadTask.observe(.pause) { snapshot in
            // Upload paused
        }
 
        
////
        //PROGRESS: observes the percentage / 100 that the image is uploading
        uploadTask.observe(.progress) { snapshot in
            // Upload reported progress
            let percentProgress = 100.0 * Double(snapshot.progress!.completedUnitCount)
                / Double(snapshot.progress!.totalUnitCount)
            print(percentProgress)
        }
        
        //SUCCESS: when the image successully is stored.. do this
        uploadTask.observe(.success) { snapshot in
            // Upload completed successfully: set users and posts imageURL
            let imageURL = String(describing: snapshot.metadata!.downloadURL()!)

            switch type {
            case .user:
                Database.database().reference(withPath: "users").child(uid).child("image").setValue(imageURL) //users/uid/image = pic
            case .post:
                Database.database().reference(withPath: "posts").child(uid).child("image").setValue(imageURL)
            }
        }
////
        
        
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
    
    //Getting the image from firebase
    func retrieveImage(imgURL: String,
                       completionHandler: @escaping (UIImage) -> Void,
                       errorHandler: @escaping (Error) -> Void) {
        ImageHelper.manager.getImage(from: imgURL,
                                     completionHandler: { completionHandler($0)},
                                     errorHandler: { errorHandler($0) })
    }
}
