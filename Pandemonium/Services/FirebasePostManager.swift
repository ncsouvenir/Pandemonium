//
//  FirebasePostManager.swift
//  Pandemonium
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import Firebase
enum FireBasePostManagerStatus: Error {
    case postAddedSuccessfully
    case noCurrentUserSignedIn
    case userHaveNoPost
}

class FirebasePostManager{
    
    private init(){}
    static let manager = FirebasePostManager()
    
    //MARK: Loading Posts FROM FireBase
    func loadPosts(completionHandler: @escaping ([Post]?, Error?) -> Void){
        // getting the reference for the node that is Posts
        let dbReference = Database.database().reference().child("posts")
        dbReference.observe(.value){(snapshot) in
            guard let snapshots = snapshot.children.allObjects as? [DataSnapshot] else {print("posts node has no children");return}
            var allPosts = [Post]()
            for snap in snapshots {
                //convert to json
                guard let rawJSON = snap.value else {continue}
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: rawJSON, options: [])
                    let post = try JSONDecoder().decode(Post.self, from: jsonData)
                    allPosts.append(post)
                    print("post added to Post array")
                }catch{
                    print(error)
                }
            }
            completionHandler(allPosts, nil)
            
            //refactor with custom delegate methods
            if allPosts.isEmpty {
                print("There are no posts in the database")
            } else {
                print("posts loaded successfully!")
            }
        }
    }
    
    //MARK: Adding posts FROM VC to Firebase
    func addPost(userUID: String, date: String, title: String, tags: [String], bodyText: String?, url: String?, image: UIImage?) {
        let child = Database.database().reference(withPath: "posts").childByAutoId()
        let post = Post(postUID: child.key, userUID: userUID, date: date, title: title, upvotes: 0, downvotes: 0, tags: tags, bodyText: bodyText, url: url, image: nil, comments: nil)
        child.setValue(post.postToJSON())
        
    }
    func addPosting(post: Post)->FireBasePostManagerStatus{
        guard let currentUser = FirebaseUserManager.shared.getCurrentUser() else{return FireBasePostManagerStatus.noCurrentUserSignedIn}
        let child = Database.database().reference(withPath: "posts").childByAutoId()
        let childKey = child.key
        child.setValue(post.postToJSON())
        //get the user by looking in the dataBase for the UID and add the childKey to the user postUIDS
        let userChild = Database.database().reference(withPath: "users").child(currentUser.uid)
        
        
        
        
        return FireBasePostManagerStatus.postAddedSuccessfully
    }
    //this function will load the post of a user
    func loadUserPosts(user: Parrot, completionHandler: @escaping ([Post]) -> Void, errorHandler: @escaping (Error) -> Void) {
        //here I need to loop through the userPost's array and get the posts
        guard let postUIDS = user.posts else {
            errorHandler(FireBasePostManagerStatus.userHaveNoPost)
            return
        }
        var posts = [Post]()
        for postUID in postUIDS{
            getPost(from: postUID, completion: {posts.append($0)}, errorHandler: {print($0)})
        }
        completionHandler(posts)
    }
    
    // this function will get a post from posUID
    func getPost(from postUID: String, completion: @escaping (Post)->Void, errorHandler: @escaping (Error)->Void){
        let postReference = Database.database().reference(withPath: "posts").child(postUID)
        postReference.observe(.value) { (snapshot) in
            guard let rawJSON = snapshot.value else{
                return
            }
            do{
                let jsonData = try JSONSerialization.data(withJSONObject: rawJSON, options: [])
                let post = try JSONDecoder().decode(Post.self, from: jsonData)
                completion(post)
            }
            catch let error{
                errorHandler(error)
            }
        }
        
    }
    func updatePostUpVote(for post: Post){
        let dbReference = Database.database().reference().child("posts")
        let postReference = dbReference.child(post.postUID)
        let postUpVotesValue = post.upvotes + 1
        postReference.updateChildValues(["upvotes": postUpVotesValue])
    }
    func updatePostDownVote(for post: Post){
        let dbReference = Database.database().reference().child("posts")
        let postReference = dbReference.child(post.postUID)
        guard (post.upvotes - post.downvotes) > 0 else {return}
        let postUpVotesValue = post.downvotes + 1
        postReference.updateChildValues(["downvotes": postUpVotesValue])
    }
    

    func loadPostsFromUser(_ uid: String) {
        
    }
}
