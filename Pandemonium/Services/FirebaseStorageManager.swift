//
//  FirebaseStorageManager.swift
//  Pandemonium
//
//  Created by Reiaz Gafar on 2/7/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import FirebaseStorage

class FirebaseStorageManager {
    private init() {
        storageRef = Storage.storage().reference()
    }
    static let shared = FirebaseStorageManager()
    
    var storageRef: StorageReference!
    
    func storeImage(name: String, image: UIImage) {
        
    }
    
    func retrieveImage() {
        
    }
    
    
}
