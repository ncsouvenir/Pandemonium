//
//  UserCommentTableViewCell.swift
//  
//
//  Created by C4Q on 1/30/18.
//

import UIKit

//MARK: called "CommentCell"
class UserCommentTableViewCell: UITableViewCell {
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
    
}

extension UserCommentTableViewCell {
    private func setupViews() {
        setupCommentLabel()
        setupUsernameLabel()
        setupDateLabel()
    }
    
    private func setupCommentLabel() {
        addSubview(commentLabel)
        commentLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(snp.leading).offset(4)
            make.top.equalTo(snp.top).offset(4)
            make.trailing.equalTo(snp.trailing).offset(-4)
        }
    }
    
    private func setupUsernameLabel() {
        addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(commentLabel.snp.leading)
            make.top.equalTo(commentLabel.snp.bottom).offset(4)
            make.bottom.equalTo(snp.bottom).offset(-4)
        }
    }
    
    private func setupDateLabel() {
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(commentLabel.snp.trailing)
            make.top.equalTo(commentLabel.snp.bottom).offset(4)
            make.bottom.equalTo(snp.bottom).offset(-4)
        }
    }
    
}
