//
//  NewCommentView.swift
//  
//
//  Created by C4Q on 1/30/18.
//

import UIKit

class NewCommentView: UIView {
    
    lazy var commentTextView: UITextView = {
        let tv = UITextView()
        tv.textColor = Settings.manager.textColor
        tv.layer.cornerRadius = 1
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
        backgroundColor = .white
        setupViews()
    }
    private func setupViews() {
        addSubview(commentTextView)
        commentTextView.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.5)
        }
    }
    
}
