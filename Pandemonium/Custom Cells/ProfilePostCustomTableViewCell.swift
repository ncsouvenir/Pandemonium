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
        label.text = "Wego wego, some cats and dogs with some parots flying"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
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
        label.text = "2"
        return label
    }()
    lazy var upVotesAndDownVotesImageView: UIImageView = {
        var imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "upAndDownArrows")
        return imageView
    }()
    lazy var numberOfUpDown: UILabel = {
        let label = UILabel()
        label.text = "33"
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
    }
    private func setupPostTitle(){
        addSubview(postTitle)
        postTitle.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(snp.top).offset(5)
            constraint.left.equalTo(snp.left).offset(5)
            constraint.width.equalTo(snp.width).multipliedBy(0.75)
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
            constraint.centerY.equalTo(postTitle.snp.centerY)
            constraint.width.height.equalTo(snp.width).multipliedBy(0.07)
        }
    }

}
