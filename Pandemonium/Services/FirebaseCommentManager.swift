//
//  FirebaseCommentManager.swift
//  Pandemonium
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import Foundation
import Firebase

class FirebaseCommentManager {
    private init() {}
    static let manager = FirebaseCommentManager()
    
    //MARK: Adding comments to posts
    func addComment(comment: String) {
        
        let dbReference = Database.database().reference().child("comments")
        let child = dbReference.childByAutoId()
        let comment1 = Comment(commentUID: child.key, userUID: "ggr15", postUID: "somePostID", date: "\(Date())", commentText: comment)
        child.setValue(comment1.commentToJson())
        
        
        let postChild = getPostChild(uid: "post.uid")
        let key = postChild.key
        
        postChild.updateChildValues(["comments" : "comment.uid"])
        
        
        
        
        //        let post2 = Post(postUID: id.key, userUID: "1", date: "010118", title: "Awesome Cats", upvotes: 1999, downvotes: 0, tags: [""], bodyText: "Cats are the best ever", url: nil, image: "sdfs", comments: ["CommentID": comment1])
        //id.setValue(comment1.commentToJson())
    }
    
    func getPostChild(uid: String) -> DatabaseReference {
        return Database.database().reference(withPath: "posts").child(uid)
    }
    
//    func getPost(uid: String,
//                 completionHandler: @escaping (Post) -> Void,
//                 errorHandler: @escaping (Error) -> Void) {
//        Database.database().reference(withPath: "posts").child(uid).observeSingleEvent(of: .value) { (snapshot) in
//            if let json = snapshot.value {
//                do {
//                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
//                    let post = try JSONDecoder().decode(Post.self, from: jsonData)
//                    completionHandler(post)
//                } catch {
//                    print(error)
//                    errorHandler(error)
//                }
//            }
//        }
//    }
    
    //MARK: Loading Comments from FireBase
    func loadComments(completionHandler: @escaping ([Comment]?, Error?) -> Void){
        // getting the reference for the node that is Comments
        let dbReference = Database.database().reference().child("comment")
        dbReference.observe(.value){(snapshot) in
            guard let snapshots = snapshot.children.allObjects as? [DataSnapshot] else {print("comment has no children");return}
            var allComments = [Comment]()
            for snap in snapshots {
                //convert to json
                guard let rawJSON = snap.value else {continue}
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: rawJSON, options: [])
                    let comment = try JSONDecoder().decode(Comment.self, from: jsonData)
                    allComments.append(comment)
                    print("comment added")
                }catch{
                    print(error)
                }
            }
            completionHandler(allComments, nil)
            if allComments.isEmpty {
                print("There are no comments in the database")
            } else {
                print("comments loaded successfully!")
            }
        }
    }
}
