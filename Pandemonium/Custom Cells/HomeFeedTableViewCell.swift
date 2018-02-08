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
    func userNameSelected(from tablViewCell: HomeFeedTableViewCell)
}

//MARK: called "Feed Cell"
class HomeFeedTableViewCell: UITableViewCell{
    var currentIndexPath: IndexPath?
    weak var delegate: HomeFeedTableViewCellDelegate?
    
    
    lazy var numberOfComments: UILabel = {
        let label = UILabel()
        label.text = "256"
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    lazy var upButton: UIButton = {
        let button = UIButton.init(type: UIButtonType.system)
        button.setImage(#imageLiteral(resourceName: "up-arrow"), for: .normal)
        button.addTarget(self, action: #selector(upVoteAction), for: .touchUpInside)
        return button
    }()
    lazy var downButton: UIButton = {
        let button = UIButton.init(type: UIButtonType.system)
        button.setImage(#imageLiteral(resourceName: "down-arrow"), for: .normal)
        button.addTarget(self, action: #selector(downVoteAction), for: .touchUpInside)
        return button
    }()
    
    lazy var userName: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        let tap = UITapGestureRecognizer(target: self, action: #selector(userNameSelectedAction))
        tap.delegate = self
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        return label
    }()
    
    lazy var postTitle: UILabel = {
        let label = UILabel()
        label.text = "Wego wego, some cats and dogs with some parots flying with a mystery on there shoulders, who knows, who cares"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.numberOfLines = 3
        return label
    }()
    lazy var tags: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("#Nature, #Adventure", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
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
        setupUserName()
        setupUpbutton()
        setupNumberOfUpDownVotes()
        setupDownButton()
        setupPostImage()
        setupNumberOfComments()
        setupCommentImageView()
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
            constraint.top.equalTo(snp.top).offset(5)
            constraint.right.equalTo(upButton.snp.left).offset(-5)
            constraint.width.height.equalTo(snp.width).multipliedBy(0.20)
        }
    }
    private func setupNumberOfUpDownVotes(){
        addSubview(numberOfUpDown)
        numberOfUpDown.snp.makeConstraints { (constraint) in
            constraint.right.equalTo(snp.right).offset(-5)
            constraint.top.equalTo(upButton.snp.bottom).offset(2)
        }
    }
    private func setupCommentImageView(){
        addSubview(commentImageView)
        commentImageView.snp.makeConstraints { (constraint) in
            constraint.right.equalTo(numberOfComments.snp.left).offset(-2)
            constraint.centerY.equalTo(numberOfComments.snp.centerY)
            constraint.width.height.equalTo(snp.width).multipliedBy(0.07)
            
        }
    }
    private func setupNumberOfComments(){
        addSubview(numberOfComments)
        numberOfComments.snp.makeConstraints { (constraint) in
            constraint.right.equalTo(snp.right).offset(-5)
            constraint.top.equalTo(downButton.snp.bottom).offset(10)
        }
    }
    private func setupUpbutton(){
        addSubview(upButton)
        upButton.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(snp.top).offset(5)
            constraint.right.equalTo(snp.right).offset(-5)
        }
    }
    private func setupDownButton(){
        addSubview(downButton)
        downButton.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(numberOfUpDown.snp.bottom).offset(2)
            constraint.right.equalTo(snp.right).offset(-5)
        }
    }
    private func setupUserName(){
        addSubview(userName)
        userName.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(postTitle.snp.bottom).offset(2)
            constraint.left.equalTo(snp.left).offset(5)
        }
    }
    
    func setupCell(with post: Post){
        self.postTitle.text = post.title
        //TODO: this will be replaced with a function to get the user by the userID
        self.userName.text = post.userUID
        self.tags.setTitle(post.tags.joined(separator: ","), for: .normal)
        if let comments = post.comments?.count {
        self.numberOfComments.text = "\(comments)"
        }
        let postUpDownValue = post.upvotes - post.downvotes
        if postUpDownValue > 1000{
            self.numberOfUpDown.text = "\(Double(postUpDownValue/1000))k"
            
        }else{
            self.numberOfUpDown.text = "\(postUpDownValue)"
        }
        
        // NightMode
        self.postTitle.textColor = Settings.manager.textColor
        self.numberOfComments.textColor = Settings.manager.textColor
        self.postImage.backgroundColor = Settings.manager.textColor
        self.numberOfUpDown.textColor = Settings.manager.textColor
    }
    
    
    @objc private func upVoteAction() {
        // TODO set delegate
        self.delegate?.upVoted(from: self)
        
    }
    
    @objc private func downVoteAction() {
        self.delegate?.downVoted(from: self)
        // TODO set delegate
    }
    @objc private func userNameSelectedAction(){
        self.delegate?.userNameSelected(from: self)
    }
    
    
}
