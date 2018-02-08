//
//  MenuView.swift
//  Pandemonium
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class MenuView: UIView {
    lazy var exitButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Back", for: .normal)
        button.titleLabel?.textColor = .black
        return button
    }()
    lazy var signInButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Sign in", for: .normal)
        button.titleLabel?.textColor = .black
        return button
    }()
    lazy var signOutButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Sign out", for: .normal)
        button.titleLabel?.textColor = .black
        return button
    }()
    lazy var profileButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Profile", for: .normal)
        button.titleLabel?.textColor = .black
        return button
    }()
    lazy var createNewAccount: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Create New Account", for: .normal)
        button.titleLabel?.textColor = .black
        return button
    }()
    lazy var homeButton: UIButton = {
        let button = UIButton(type: UIButtonType.system)
        button.setTitle("Home", for: .normal)
        button.titleLabel?.textColor = .black
        return button
    }()
    lazy var stackView: UIStackView = {
        let sView = UIStackView(arrangedSubviews: [homeButton,signInButton, signOutButton, profileButton, createNewAccount])
        sView.axis = .vertical
        sView.distribution = .fillEqually
        sView.alignment = UIStackViewAlignment.leading
        sView.spacing = 5
        return sView
    }()
    
    
    lazy var tableView: UITableView = {
        let tView = UITableView()
        tView.register(UITableViewCell.self, forCellReuseIdentifier: "menuCell")
        tView.backgroundColor = .orange
        return tView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(displayP3Red: 238/255, green: 242/255, blue: 245/255, alpha: 0.85 )
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews(){
        setupExitButton()
        setupStackView()
        //        setupTableView()
    }
    func setupExitButton(){
        addSubview(exitButton)
        exitButton.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(snp.top).offset(5)
            constraint.right.equalTo(snp.right).offset(-10)
        }
    }
    func setupTableView(){
        addSubview(tableView)
        tableView.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(exitButton.snp.bottom).offset(5)
            constraint.left.equalTo(snp.left)
            constraint.right.equalTo(snp.right)
            constraint.bottom.equalTo(snp.bottom)
        }
        
    }
    func setupStackView(){
        addSubview(stackView)
        stackView.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(exitButton.snp.bottom).offset(10)
            constraint.right.equalTo(snp.right)
            constraint.left.equalTo(snp.left)
            constraint.height.equalTo(snp.height).multipliedBy(0.45)
        }
    }
}
