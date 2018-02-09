//
//  ProfilePostCustomTableViewCell.swift
//  Pandemonium
//
//  Created by C4Q on 2/2/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class ProfilePostCustomTableViewCell: UITableViewCell {
    lazy var postTitle: UILabel = {
        let label = UILabel()
        label.text = "Wego wego, some cats and dogs with some parots flying with a mystery on there shoulders, who knows, who cares"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 3
        return label
    }()
    lazy var tags: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("#Nature, #Adventure", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    lazy var numberOfComments: UILabel = {
        let label = UILabel()
        label.text = "256"
        label.font = UIFont.systemFont(ofSize: 10)
        
        return label
    }()
    lazy var upVotesAndDownVotesImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "upAndDownArrows")
        return imageView
    }()
    lazy var numberOfUpDown: UILabel = {
        let label = UILabel()
        label.text = "363"
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    lazy var postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.image = #imageLiteral(resourceName: "warMachine")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .yellow
        return imageView
    }()
    lazy var commentImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "comments")
        return imageView
    }()
    lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "profilePostCell")
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    private func setupViews(){
        setupPostTitle()
        setupTags()
        setupUpVotesAndDownVotesImageView()
        setupPostImage()
        setupNumberOfUpDownVotes()
        setupCommentImageView()
        setupNumberOfComments()
        setupUserName()
    }
    private func setupPostTitle(){
        addSubview(postTitle)
        postTitle.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(snp.top).offset(5)
            constraint.left.equalTo(snp.left).offset(5)
            constraint.width.equalTo(snp.width).multipliedBy(0.68)
        }
    }
    private func setupTags(){
        addSubview(tags)
        tags.snp.makeConstraints { (constraint) in
            constraint.bottom.equalTo(snp.bottom).offset(-5)
            constraint.left.equalTo(snp.left).offset(5)
            constraint.width.equalTo(snp.width).multipliedBy(0.35)
        }
    }
    private func setupUpVotesAndDownVotesImageView(){
        addSubview(upVotesAndDownVotesImageView)
        upVotesAndDownVotesImageView.snp.makeConstraints { (constraint) in
            constraint.left.equalTo(postTitle.snp.right).offset(5)
            constraint.top.equalTo(snp.top).offset(5)
            constraint.width.height.equalTo(snp.width).multipliedBy(0.07)
        }
    }
    private func setupPostImage(){
        addSubview(postImage)
        postImage.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(upVotesAndDownVotesImageView.snp.bottom).offset(2)
            constraint.right.equalTo(snp.right).offset(-5)
            constraint.width.height.equalTo(snp.width).multipliedBy(0.20)
        }
    }
    private func setupNumberOfUpDownVotes(){
        addSubview(numberOfUpDown)
        numberOfUpDown.snp.makeConstraints { (constraint) in
            constraint.left.equalTo(upVotesAndDownVotesImageView.snp.right).offset(2)
            constraint.centerY.equalTo(upVotesAndDownVotesImageView.snp.centerY)
        }
    }
    private func setupCommentImageView(){
        addSubview(commentImageView)
        commentImageView.snp.makeConstraints { (constraint) in
            constraint.left.equalTo(numberOfUpDown.snp.right).offset(2)
            constraint.centerY.equalTo(upVotesAndDownVotesImageView.snp.centerY)
            constraint.width.height.equalTo(snp.width).multipliedBy(0.07)
            
        }
    }
    private func setupNumberOfComments(){
        addSubview(numberOfComments)
        numberOfComments.snp.makeConstraints { (constraint) in
            constraint.left.equalTo(commentImageView.snp.right)
            constraint.centerY.equalTo(commentImageView.snp.centerY)
        }
    }
    private func setupUserName(){
        addSubview(userName)
        userName.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(postTitle.snp.bottom).offset(2)
            constraint.left.equalTo(snp.left).offset(5)
        }
    }
    
    func setupCell(from post: Post){
        self.postTitle.text = post.title
        //TODO: this will be replaced with a function to get the user by the userID
        self.userName.text = post.userUID
        self.tags.setTitle(post.tags.joined(separator: ","), for: .normal)
        self.numberOfComments.text = "\(post.comments?.count ?? 0)"
        let postUpDownValue = post.upvotes - post.downvotes
        if postUpDownValue > 1000{
            self.numberOfUpDown.text = "\(Double(postUpDownValue/1000))k"
            
        }else{
            self.numberOfUpDown.text = "\(postUpDownValue)"
        }
        
    }
    
}
