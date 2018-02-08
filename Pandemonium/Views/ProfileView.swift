//
//  ProfileView.swift
//  
//
//  Created by C4Q on 1/30/18.
//

import UIKit

class ProfileView: UIView {
    
    lazy var tableView: UITableView = {
        
        let tView = UITableView()
        tView.register(UITableViewCell.self, forCellReuseIdentifier: "defaulCell")
        tView.register(ProfileImageCustomTableViewCell.self, forCellReuseIdentifier: "profileImageCell")
        tView.register(CurrentUserProfileImageCustomTableViewCell.self, forCellReuseIdentifier: "currentUserImageCell")
        tView.register(ProfilePostCustomTableViewCell.self, forCellReuseIdentifier: "profilePostCell")
        tView.register(CurrentUserProfilePostCustomCustomTableViewCell.self, forCellReuseIdentifier: "currentUserProfilePostCell")
        return tView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupViews(){
        addSubview(tableView)
        tableView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(snp.edges)
        }
        
    }
    
}

