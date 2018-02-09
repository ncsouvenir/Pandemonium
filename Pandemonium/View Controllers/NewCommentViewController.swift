//
//  NewCommentViewController.swift
//  Pandemonium
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class NewCommentViewController: UIViewController {
    
        var post: Post!
    
        init(post: Post) {
            super.init(nibName: nil, bundle: nil)
            self.post = post
        }
    
        required init?(coder aDecoder: NSCoder) {
            fatalError()
        }
    
    let commentView = NewCommentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavBar()
        constrainView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        commentView.commentTextView.becomeFirstResponder()
    }
    
    private func constrainView() {
        view.addSubview(commentView)
        commentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    private func configNavBar() {
        navigationItem.title = "New Comment"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(submitPost))
        Settings.manager.navBarNightMode(navbar: navigationController!.navigationBar)
//        navigationController?.navigationBar.backgroundColor = Settings.manager.backgroundColor
        
    }
    @objc private func dismissView() {
        commentView.commentTextView.resignFirstResponder()
        dismiss(animated: true, completion: nil)
    }
    @objc private func submitPost() {
        //TODO: post comment
        guard let comment = commentView.commentTextView.text else {return}
        guard !comment.isEmpty else {
            showAlert(title: "Error", message: "No comment added")
            return
        }
        
        FirebaseCommentManager.manager.addComment(comment: comment, post: post)
        dismiss(animated: true, completion: nil)
    }
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
}
