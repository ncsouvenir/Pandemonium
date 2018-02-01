//
//  LoginVC.swift
//  
//
//  Created by C4Q on 1/30/18.
//

import UIKit

class LoginVC: UIViewController {

    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
        
        loginView.submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        
        loginView.forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        
        loginView.createNewAccountButton.addTarget(self, action: #selector(createNewAccountButtonTapped), for: .touchUpInside)
        
    }

    @objc private func submitButtonTapped() {
        
    }
    
    @objc private func forgotPasswordButtonTapped() {
        
    }
    
    @objc private func createNewAccountButtonTapped() {
        
    }
    
}

extension LoginVC {
    
}
