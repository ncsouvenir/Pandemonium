//
//  CreatePostSelectedImageVC.swift
//  Pandemonium
//
//  Created by C4Q on 2/6/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class CreatePostSelectedImageVC: UIViewController {
    
    let detailSelectedmageView = CreatePostSelectedImageView()
    
    private var selectedImage: UIImage!
    
    //Injecting the larger detailed image into this View Controller
    init(selectedImage: UIImage){
        super.init(nibName: nil, bundle: nil)
        self.selectedImage = selectedImage
        detailSelectedmageView.configureImage(to: selectedImage)
        
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {//
        super.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder){// required becuase subclassing
        super.init(coder: aDecoder)
    }
    /////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(detailSelectedmageView)
        detailSelectedmageView.dismissView.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
    }
    
    
    //MARK: - button functionality
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}
