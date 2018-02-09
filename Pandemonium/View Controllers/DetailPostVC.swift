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
    var cell: HomeFeedTableViewCell?
    
    private var commentUIDs = [String]() {
        didSet {
            print(commentUIDs)
            FirebaseCommentManager.manager.observeComments(commentUIDs: commentUIDs, completionHandler: { self.comments = $0 }, errorHandler: { print($0) })
        }
    }
    private var comments = [Comment]() {
        didSet {
            // TODO: - Sort comments
            detailPostView.tableView.reloadData()
        }
    }
    
    private var detailPostView: DetailPostView!
    private var postState: PostState!

    convenience init(post: Post) {
        self.init(nibName: nil, bundle: nil)
        self.post = post
        
        if post.url != nil && post.url != "" {
            postState = .url
            detailPostView = DetailPostView(postState: postState)
        } else if post.image != nil {
            postState = .image
            detailPostView = DetailPostView(postState: postState)
        } else if post.bodyText != nil {
            postState = .text
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
        setupNavBar()
        setupPostInfo()
        if let state = postState {
            switch state {
            case .text:
                detailPostView.postTextView.text = post.bodyText
            case .image:
                FirebaseStorageManager.shared.retrieveImage(imgURL: post.image!, completionHandler: { self.detailPostView.postImageView.image = $0 }, errorHandler: { print($0) })
            case .url:
                if let url = URL(string: post.url!) {
                    let request = URLRequest(url: url)
                    detailPostView.postWebKitView.load(request)
                    detailPostView.postWebKitView.reload()
                } else {
                    detailPostView.postWebKitView.load(URLRequest(url: URL(string: "https://www.google.com/404")!))
                }
            }
        }
        
        detailPostView.tableView.dataSource = self
        setupButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        FirebaseCommentManager.manager.loadCommentUIDs(postUID: post.postUID, completionHandler: { self.commentUIDs = $0 }, errorHandler: { print($0); self.noCommentAlert() } )
    }
    
    private func noCommentAlert() {
        let alertController = UIAlertController(title: "No Comments", message: "There are no comments for this post yet.  Why dont you add one?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    private func setupNavBar() {
        let menuButton = UIBarButtonItem(image: #imageLiteral(resourceName: "list"), style: .plain, target: self, action: #selector(menuButtonTapped))
        let addCommentButton = UIBarButtonItem(image: #imageLiteral(resourceName: "plus-symbol"), style: .plain, target: self, action: #selector(addCommentButtonTapped))
        navigationItem.rightBarButtonItems = [menuButton, addCommentButton]
    }
    
    @objc private func menuButtonTapped() {
        //TODO: set up
    }
    
    @objc private func addCommentButtonTapped() {
        //        let addCommentVC = NewCommentViewController(post: post)
        //        navigationController?.pushViewController(addCommentVC, animated: true)
        if FirebaseUserManager.shared.getCurrentUser() == nil {
            present(LoginVC(), animated: true, completion: nil)
        }
        
        let addCommentVC = UINavigationController(rootViewController: NewCommentViewController(post: post))
        present(addCommentVC, animated: true, completion: nil)
    }
    
    private func setupPostInfo() {
        FirebaseUserManager.shared.getUsernameFromUID(uid: post.userUID, completionHandler: { self.detailPostView.usernameLabel.text = $0 }, errorHandler: { print($0) })
        detailPostView.karmaLabel.text = (post.upvotes - post.downvotes).description
        detailPostView.dateLabel.text = post.date
    }
    
    private func setupButtons() {
        detailPostView.upvoteButton.addTarget(self, action: #selector(upvoteTapped), for: .touchUpInside)
        detailPostView.downvoteButton.addTarget(self, action: #selector(downvoteTapped), for: .touchUpInside)
    }
    
    @objc private func upvoteTapped() {
        FirebasePostManager.manager.updatePostUpVote(for: post)
    }
    
    @objc private func downvoteTapped() {
        FirebasePostManager.manager.updatePostDownVote(for: post)
    }
    
}


extension DetailPostVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! UserCommentTableViewCell
        cell.isUserInteractionEnabled = false
        let comment = comments[indexPath.row]
        cell.commentLabel.text = comment.commentText
        cell.dateLabel.text = comment.date
        FirebaseUserManager.shared.getUsernameFromUID(uid: comment.userUID, completionHandler: { cell.usernameLabel.text =  $0 }, errorHandler: { print($0) })
        cell.setNeedsLayout()
        
        return cell
    }
}
