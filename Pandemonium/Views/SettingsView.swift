//
//  SettingsView.swift
//  Pandemonium
//
//  Created by C4Q on 2/6/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class SettingsView: UIView {
    
    lazy var colorLabel: UILabel = {
        let label = UILabel()
        label.text = "Color Schemes:"
//        label.font = Settings.manager.fontSize
        label.textColor = Settings.manager.textColor
        return label
    }()
    
    lazy var colorButton: UIButton = {
        let button = UIButton()
        button.setTitle("Normal", for: .normal)
        button.setTitleColor(Settings.manager.textColor, for: .normal)
        return button
    }()
    
    lazy var colorTableView: UITableView = {
        let tv = UITableView()
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "ColorCell")
        tv.isHidden = true
        return tv
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        backgroundColor = Settings.manager.background
        setupViews()
    }
    private func setupViews() {
        addSubview(colorButton)
        addSubview(colorTableView)
        addSubview(colorLabel)
        let padding = 40
        
        colorLabel.snp.makeConstraints { (make) in
            make.top.leading.equalTo(self).offset(padding)
        }
        colorButton.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(padding)
            make.leading.equalTo(colorLabel.snp.trailing).offset(padding - 20)
            make.width.equalTo(padding + 60)
        }
        colorTableView.snp.makeConstraints { (make) in
            make.width.equalTo(colorButton)
//            make.height.equalTo(20)
            make.top.equalTo(colorButton.snp.bottom)
            
        }
        
    }

}
