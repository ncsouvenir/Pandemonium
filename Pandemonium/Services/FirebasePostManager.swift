//
//  FirebasePostManager.swift
//  Pandemonium
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import Firebase

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
    func addPosts() {
        let comment1 = Comment(commentUID: "asd4149", userUID: "will&&", postUID: "somePostID", date: "01022018", commentText: "awesome cats")

        let dbReference = Database.database().reference().child("posts")
        let id = dbReference.childByAutoId()
                let post2 = Post(postUID: id.key, userUID: "-L4laCvUNm9VvaiqnXxh", date: "010118", title: "Awesome Cats", upvotes: 1999, downvotes: 0, tags: [""], bodyText: "Cats are the best ever", url: nil, image: "sdfs", comments: [""])
        id.setValue(post2.postToJSON())
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
}
