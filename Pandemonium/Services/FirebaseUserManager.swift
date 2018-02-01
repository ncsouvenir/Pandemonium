//
//  FirebaseUserManager.swift
//  Pandemonium
//
//  Created by C4Q on 1/31/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

enum AuthError: Error {
    case badChildren
    case badKey
}

class FirebaseUserManager {
    static let shared = FirebaseUserManager()
    private init() {}
    
    func login(with email: String,
               and password: String,
               completionHandler: @escaping (User?, Error?) -> Void) {
        
        let completion: (User?, Error?) -> Void = { (user, error) in
            if let error = error {
                completionHandler(nil, error)
            } else if let user = user {
                completionHandler(user, nil)
            }
        }
        
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        
    }
    
    func createAccount(with email: String,
                       and password: String,
                       username: String,
                       completionHandler: @escaping (User?, Error?) -> Void) {
        let completion: (User?, Error?) -> Void = { (user, error) in
            let reference = Database.database().reference().child("users")
            reference.childByAutoId().setValue(Parrot(userUID: nil, appUserName: username, upvotes: 0, downvotes: 0, numberOfComments: 0, image: nil, posts: [:]).toJSON())
        }
        Auth.auth().createUser(withEmail: email, password: password, completion: completion)
        
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
    }
    
    func forgotPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
