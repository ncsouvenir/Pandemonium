//
//  DetailPostVC.swift
//  
//
//  Created by C4Q on 1/30/18.
//

import UIKit
import FirebaseDatabase
import WebKit

enum PostState {
    case text
    case image
    case url
}

class DetailPostVC: UIViewController {

    var post: Post!
    private var comments = [Comment]() {
        didSet {
            detailPostView.tableView.reloadData()
        }
    }
    private var detailPostView: DetailPostView!
    private var postState: PostState!
    
    convenience init(post: Post) {
        self.init(nibName: nil, bundle: nil)
        self.post = post

        if post.bodyText != nil {
            postState = .text
            detailPostView = DetailPostView(postState: postState)
        }

        if post.url != nil {
            postState = .url
            detailPostView = DetailPostView(postState: postState)
        }

        if post.image != nil {
            postState = .image
            detailPostView = DetailPostView(postState: postState)
        }

    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(detailPostView)
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
        setupPostInfo()
        if let state = postState {
            switch state {
            case .text:
                detailPostView.postTextView.text = post.bodyText
            case .image:
                // TODO: - Get image
                detailPostView.postImageView.image = UIImage(contentsOfFile: post.image!)
            case .url:
                // TODO: - Handle optionals
//                detailPostView.postWebKitView.uiDelegate = self
                let google = URLRequest(url: URL(string: "http://www.reddit.com")!)
                
                let url = URL(string: post.url!)
                let request = URLRequest(url: url!)
                detailPostView.postWebKitView.load(google)
                detailPostView.postWebKitView.reload()
            }
        }

        
        detailPostView.tableView.dataSource = self
        detailPostView.tableView.delegate = self
        
        
        print("the post state is \(postState)")
        observeComments()

    }
    
    private func setupPostInfo() {
        // TODO: - Stuff in comments
        getUsernameFromUID(uid: post.userUID, completionHandler: { self.detailPostView.usernameLabel.text = $0 }, errorHandler: { print($0) })
        detailPostView.karmaLabel.text = (post.upvotes - post.downvotes).description
        detailPostView.dateLabel.text = post.date
    }
    
    func getImageFromFirebaseStorage(imageUID: String) {
    }
    
    // Get username from the userUID in injected Post
    func getUsernameFromUID(uid: String,
                            completionHandler: @escaping (String) -> Void,
                            errorHandler: @escaping (Error) -> Void) {
        Database.database().reference(withPath: "users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            if let json = snapshot.value {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                    let user = try JSONDecoder().decode(Parrot.self, from: jsonData)
                    completionHandler(user.appUserName)
                } catch {
                    print(error)
                    errorHandler(error)
                }
            }
        }
    }
    
    // Gets Array of commentUIDs
    // Then asynchroniously get the values for the comments
    func observeComments() {
        Database.database().reference(withPath: "posts").child("postUID").child("comments").observe(.value) { (dataSnapshot) in
            guard let commentsUIDSnapshot = dataSnapshot.children.allObjects as? [DataSnapshot] else { print("comments array in post is nil"); return }
            
            var commentUIDArray = [String]()
            for snap in commentsUIDSnapshot {
                guard let json = snap.value else { return }
                do {
                    let arrayJSONData = try JSONSerialization.data(withJSONObject: json, options: [])
                    commentUIDArray = try JSONDecoder().decode([String].self, from: arrayJSONData)
                } catch {
                    print(error)
                }
            }
            var firComments = [Comment]()
            for uid in commentUIDArray {

                DispatchQueue.main.async {
                    if let firCommentAsJSON = Database.database().reference(withPath: "comments").value(forKey: uid) {
                        do {
                            let firCommentJSONData = try JSONSerialization.data(withJSONObject: firCommentAsJSON, options: [])
                            let firComment = try JSONDecoder().decode(Comment.self, from: firCommentJSONData)
                            firComments.append(firComment)
                        } catch {
                            print(error)
                        }
                    }
                }
            }
            self.comments = firComments
        }
    }
    
}



extension DetailPostVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! UserCommentTableViewCell
        let comment = comments[indexPath.row]
        cell.commentLabel.text = comment.commentText
        cell.dateLabel.text = comment.date
        getUsernameFromUID(uid: comment.userUID, completionHandler: { cell.usernameLabel.text =  $0 }, errorHandler: { print($0) })
        return cell
    }
}

extension DetailPostVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
