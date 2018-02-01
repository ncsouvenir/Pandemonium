//
//  CreateAccountVC.swift
//  
//
//  Created by C4Q on 1/30/18.
//

import UIKit
import SnapKit
import FirebaseAuth

class CreateAccountVC: UIViewController {
    
    let createView = CreateAccountView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .orange
        setupView()
    }
    private func setupDelegate() {
        createView.userNameTextField.delegate = self
        createView.emailTextField.delegate = self
        createView.passwordTextField.delegate = self
    }
    
    private func setupView() {
        view.addSubview(createView)
        FirebaseUserManager.shared.createAccount(with: "yooox3@mama.com", and: "password", username: "g3TR3kT") { (user, error) in
            if let error = error {
                print("error creatting user\(error)")
            }
            if let user = user {
                print(user.displayName)
            }
        }
        createView.snp.makeConstraints { (view) in
            view.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }

}
extension CreateAccountVC: UITextFieldDelegate {
    
}
