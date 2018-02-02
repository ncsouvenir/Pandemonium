//
//  HomeFeedTableViewCell.swift
//  
//
//  Created by C4Q on 1/30/18.
//

import UIKit
 protocol HomeFeedTableViewCellDelegate: class{
      func upVoted(from tablVieCell: HomeFeedTableViewCell)
      func downVoted(from tablVieCell: HomeFeedTableViewCell)
}

//MARK: called "Feed Cell"
class HomeFeedTableViewCell: UITableViewCell {
    var currentIndexPath: IndexPath?
    weak var delegate: HomeFeedTableViewCellDelegate?
    lazy var postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 5
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .yellow
        return imageView
    }()
    lazy var numberOfComments: UILabel = {
        let label = UILabel()
        label.text = "2"
        return label
    }()
    lazy var numberOfUpDown: UILabel = {
        let label = UILabel()
        label.text = "33"
        return label
    }()
    lazy var upButton: UIButton = {
        let button = UIButton.init(type: UIButtonType.system)
        button.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        button.addTarget(self, action: #selector(upVoteAction), for: .touchUpInside)
        return button
    }()
    lazy var downButton: UIButton = {
        let button = UIButton.init(type: UIButtonType.system)
        button.setImage(#imageLiteral(resourceName: "dislike-thumb"), for: .normal)
        button.addTarget(self, action: #selector(downVoteAction), for: .touchUpInside)
        return button
    }()
    lazy var commentButton: UIButton = {
        let button = UIButton.init(type: UIButtonType.system)
        button.setImage(#imageLiteral(resourceName: "comments"), for: .normal)
        return button
    }()
    lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "Username"
        return label
    }()
    lazy var tags: UILabel = {
        let label = UILabel()
        label.text = "Tags: 34"
        return label
    }()
    lazy var postTitle: UILabel = {
        let label = UILabel()
        label.text = "Post Title"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        return label
    }()
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "customTableViewCell")
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
    func setupViews(){
        setupTitle()
        setupTagLabel()
        setupUserName()
        setupPostImage()
        setupUpButton()
        setupNumberOfComments()
        setupCommentsButton()
        setupNumbOfUpDown()
        setupDownButton()
        
    }
    private func setupTitle(){
        addSubview(postTitle)
        postTitle.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(snp.top).offset(5)
            constraint.left.equalTo(snp.left).offset(5)
            constraint.width.equalTo(snp.width).multipliedBy(0.45)
        }
    }
    private func setupTagLabel(){
        addSubview(tags)
        tags.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(postTitle.snp.bottom).offset(5)
            constraint.left.equalTo(snp.left).offset(5)
        }
    }
    private func setupUserName(){
        addSubview(userName)
        userName.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(tags.snp.bottom).offset(5)
            constraint.left.equalTo(snp.left).offset(5)
        }
        
    }
    private func setupPostImage(){
        addSubview(postImage)
        postImage.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(snp.top).offset(5)
            constraint.left.equalTo(postTitle.snp.right).offset(5)
            constraint.height.width.equalTo(snp.width).multipliedBy(0.20)
        }
    }
    private func setupDownButton(){
        addSubview(downButton)
        downButton.snp.makeConstraints { (constraint) in
            constraint.right.equalTo(numberOfUpDown.snp.left).offset(-5)
            constraint.centerY.equalTo(upButton.snp.centerY)
        }
    }
    private func setupNumbOfUpDown(){
        addSubview(numberOfUpDown)
        numberOfUpDown.snp.makeConstraints { (constraint) in
            constraint.right.equalTo(upButton.snp.left).offset(-5)
            constraint.centerY.equalTo(upButton.snp.centerY)
        }
    }
    private func setupUpButton(){
        addSubview(upButton)
        upButton.snp.makeConstraints { (constraint) in
            constraint.right.equalTo(snp.right).offset(-5)
            constraint.top.equalTo(snp.top).offset(5)
        }
    }
    private func setupNumberOfComments(){
        addSubview(numberOfComments)
        numberOfComments.snp.makeConstraints { (constraint) in
            constraint.right.equalTo(snp.right).offset(-5)
            constraint.top.equalTo(upButton.snp.bottom).offset(20)
        }
    }
    private func setupCommentsButton(){
        addSubview(commentButton)
        commentButton.snp.makeConstraints { (constraint) in
            constraint.right.equalTo(numberOfComments.snp.left).offset(-5)
            constraint.centerY.equalTo(numberOfComments.snp.centerY)
        }
    }
    
    func setupCell(with postSetup: Post){
        self.postTitle.text = postSetup.title
        //TODO: this will be replaced with a function to get the user by the userID
        self.userName.text = postSetup.userUID
        self.tags.text = postSetup.tags.joined(separator: " ")
        self.numberOfComments.text = "\(postSetup.comments.count)"
        let postUpDownValue = postSetup.upvotes - postSetup.downvotes
        if postUpDownValue > 1000{
                    self.numberOfUpDown.text = "\(Double(postUpDownValue/1000))k"
            
        }else{
                 self.numberOfUpDown.text = "\(postUpDownValue)"
        }

    }
    
    
    @objc private func upVoteAction() {
        // TODO set delegate
        self.delegate?.upVoted(from: self)

    }
    
    @objc private func downVoteAction() {
        self.delegate?.downVoted(from: self)
        // TODO set delegate
    }
    
    
}
