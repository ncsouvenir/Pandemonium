//
//  HomeFeedView.swift
//  Pandemonium
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import SnapKit
class HomeFeedView: UIView {

    lazy var tableView: UITableView = {
        let tView = UITableView()
        tView.register(HomeFeedTableViewCell.self, forCellReuseIdentifier: "customTableViewCell")
        return tView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        setupTableView()
    }
    func setupTableView(){
        addSubview(tableView)
        tableView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(snp.edges)
        }
    }


}
