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
    let userInfo = [Parrot]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        testColors()
        setupView()
        submitButton()
    }
    private func setupDelegate() {
        createView.userNameTextField.delegate = self
        createView.emailTextField.delegate = self
        createView.passwordTextField.delegate = self
    }
    
    private func setupView() {
        view.addSubview(createView)
        
        createView.snp.makeConstraints { (view) in
            view.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    func testColors() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [UIColor.cyan.cgColor, UIColor.purple.cgColor]
        view.layer.addSublayer(gradient)
    }
    
    private func submitButton() {
        createView.submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    }
    
    @objc private func submitTapped() {
        guard let userText = createView.userNameTextField.text else {print("username is nil"); return}
        guard !userText.isEmpty else {print("user is empty"); return}
        
        guard let emailText = createView.emailTextField.text else {print("email is nil"); return}
        guard !emailText.isEmpty else {print("email is empty"); return}
        
        guard let passwordText = createView.passwordTextField.text else {print("password is nil"); return}
        guard !passwordText.isEmpty else {print("password is empty"); return}
        //TODO: Check for unique users
        if passwordText == createView.confirmPasswordTextField.text {
            FirebaseUserManager.shared.createAccount(with: emailText, and: passwordText, username: userText) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else if let user = user {
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
        } else {
            print("Passwords don't match!")
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view == createView.containerView {
                self.view.endEditing(true)
                self.resignFirstResponder()
                
            }
            if touch.view == createView.blurView {
                // TODO: - Dismiss login view controller and go back to previous vc
                dismiss(animated: true, completion: nil)
            } else {
                return
            }
        }
    }
    
}

extension CreateAccountVC: UITextFieldDelegate {
    
}
