//
//  CreatePostView.swift
//  Pandemonium
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class CreatePostSelectedImageView: UIView {
    
    lazy var dismissView: UIButton = {
        let button = UIButton(frame: UIScreen.main.bounds) //This tells the button to be the size of the screen
        button.backgroundColor = .clear
        return button
    }()
    
    //Image View
    lazy var largeImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = .red
        iv.image = #imageLiteral(resourceName: "download")
        return iv
    }()
    
    ///////Initialization
    
    override init(frame: CGRect) {//overriding the parent class's functions
        super.init(frame: UIScreen.main.bounds)
        setUpGUI()
    }
    
    required init?(coder aDecoder: NSCoder) { //now the new initializer required for this uiView
        super.init(coder: aDecoder)
        //setUpGUI()
    }

    private func setUpGUI() {
        backgroundColor = .white
        setupAndConstrainObjects()
        setupDismissView()
    }
    
    private func setupDismissView() {
        addSubview(dismissView)
    }

    ///////Constraints
    private func setupAndConstrainObjects() {
        /*
         //ARRAY MUST BE ON ORDER!!
         let UIViewObjects = [largeImageView] as [UIView]
         
         UIViewObjects.forEach{addSubview($0); ($0).translatesAutoresizingMaskIntoConstraints = false}
         */
        addSubview(largeImageView)
        largeImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //Large image
            largeImageView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            largeImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            largeImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            largeImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
            ])
    }
    
    //Configuring cell function for injection
    public func configureImage(to selectedImage: UIImage) {
        largeImageView.image = selectedImage
    }
}
