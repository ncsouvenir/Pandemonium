//
//  DetailPostView.swift
//  
//
//  Created by C4Q on 1/30/18.
//

import UIKit
import SnapKit
import WebKit

class DetailPostView: UIView {
    
    let postState: PostState
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: safeAreaLayoutGuide.layoutFrame, style: .plain)
        tableView.backgroundColor = Settings.manager.backgroundColor
        tableView.register(UserCommentTableViewCell.self, forCellReuseIdentifier: "CommentCell")
        return tableView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Settings.manager.backgroundColor
        return view
    }()
    
    lazy var postInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = Settings.manager.backgroundColor
        return view
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var karmaLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var upvoteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "up-arrow"), for: .normal)
        return button
    }()
    
    lazy var downvoteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "down-arrow"), for: .normal)
        return button
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = Settings.manager.backgroundColor
        return imageView
    }()
    
    lazy var postWebKitView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.backgroundColor = Settings.manager.backgroundColor
        return webView
    }()
    
    lazy var postTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = Settings.manager.backgroundColor
        textView.isEditable = false
        textView.font = UIFont.systemFont(ofSize: 20)
        return textView
    }()
    
    init(postState: PostState) {
        self.postState = postState
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupContainerView()
        setupPostInfoView()
        setupPostInfoViewSubviews()
        setupTableView()
        
        switch postState {
        case .text:
            setupPostTextView()
        case .url:
            setupWebView()
        case .image:
            setupPostImageView()
        }
    }
    
    
}

// MARK: - Setup Views
extension DetailPostView {
    private func setupContainerView() {
        addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.60)
        }
    }
    
    private func setupPostInfoView() {
        containerView.addSubview(postInfoView)
        postInfoView.snp.makeConstraints { (make) in
            make.bottom.equalTo(containerView.snp.bottom)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
            make.height.equalTo(containerView.snp.height).multipliedBy(0.25)
        }
    }
    
    private func setupPostInfoViewSubviews() {
        setupUsernameLabel()
        setupUpvoteButton()
        setupKarmaLabel()
        setupDownvoteButton()
        setupDateLabel()
    }
    
    private func setupUsernameLabel() {
        postInfoView.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(postInfoView.snp.top)
            make.leading.equalTo(postInfoView.snp.leading)
        }
    }
    
    private func setupUpvoteButton() {
        postInfoView.addSubview(upvoteButton)
        upvoteButton.snp.makeConstraints { (make) in
            make.top.equalTo(postInfoView.snp.top)
            make.trailing.equalTo(postInfoView.snp.trailing)
        }
    }
    
    private func setupKarmaLabel() {
        postInfoView.addSubview(karmaLabel)
        karmaLabel.snp.makeConstraints { (make) in
            make.top.equalTo(upvoteButton.snp.bottom)
            make.trailing.equalTo(postInfoView.snp.trailing)
            make.width.equalTo(upvoteButton)
        }
    }
    
    private func setupDownvoteButton() {
        postInfoView.addSubview(downvoteButton)
        downvoteButton.snp.makeConstraints { (make) in
            make.top.equalTo(karmaLabel.snp.bottom)
            make.trailing.equalTo(postInfoView.snp.trailing)
        }
    }
    
    private func setupDateLabel() {
        postInfoView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(postInfoView.snp.bottom)
            make.leading.equalTo(postInfoView.snp.leading)
        }
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(containerView.snp.bottom)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setupPostImageView() {
        containerView.addSubview(postImageView)
        postImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(postInfoView.snp.top)
            make.top.equalTo(containerView.snp.top)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
        }
    }
    
    private func setupWebView() {
        containerView.addSubview(postWebKitView)
        postWebKitView.snp.makeConstraints { (make) in
            make.bottom.equalTo(postInfoView.snp.top)
            make.top.equalTo(containerView.snp.top)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
        }
    }
    
    private func setupPostTextView() {
        containerView.addSubview(postTextView)
        postTextView.snp.makeConstraints { (make) in
            make.bottom.equalTo(postInfoView.snp.top)
            make.top.equalTo(containerView.snp.top)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
        }
    }
    
    
}
