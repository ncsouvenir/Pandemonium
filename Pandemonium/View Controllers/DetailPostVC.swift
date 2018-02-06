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
                //detailPostView.postWebKitView.uiDelegate = self
                let google = URLRequest(url: URL(string: "http://www.reddit.com")!)
                
                let url = URL(string: post.url!)
                let request = URLRequest(url: url!)
                detailPostView.postWebKitView.load(google)
                detailPostView.postWebKitView.reload()
            }
        }

        
        detailPostView.tableView.dataSource = self
        detailPostView.tableView.delegate = self
        
        
        
        observeComments()

    }
    
    private func setupPostInfo() {
        // TODO: - Stuff in comments
        detailPostView.usernameLabel.text = post.postUID // get username from UIS
        detailPostView.karmaLabel.text = (post.upvotes - post.downvotes).description
        detailPostView.dateLabel.text = post.date
    }
    
    func getImageFromFirebaseStorage(imageUID: String) {
    }
    
    func observeComments() {
        Database.database().reference(withPath: "posts").child("id").child("comments").observe(.value) { (dataSnapshot) in
            let snapshots = dataSnapshot.children.allObjects as! [DataSnapshot]
            var loadedComments = [Comment]()
            DispatchQueue.main.async {
                for snap in snapshots {
                    if let json = snap.value {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
                            let comment = try JSONDecoder().decode(Comment.self, from: jsonData)
                            loadedComments.append(comment)
                        } catch {
                            print(error)
                        }
                    }
                    
                }
            }
            self.comments = loadedComments
        }
    }
    
    
    
}



extension DetailPostVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! UserCommentTableViewCell

//        let comment = comments[indexPath.row]
//        
//        DispatchQueue.main.async {
//            cell.commentLabel.text = comment.commentText
//            cell.dateLabel.text = comment.date
//
//            let user = Database.database().reference(withPath: "users").value(forKey: comment.userUID) as! Parrot
//            cell.usernameLabel.text = user.appUserName
//            
//            cell.setNeedsLayout()
//        }
        
        

        return cell
    }
}

extension DetailPostVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
