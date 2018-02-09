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
        view.addSubview(createView)
        submitButton()
    }
    private func setupDelegate() {
        createView.userNameTextField.delegate = self
        createView.emailTextField.delegate = self
        createView.passwordTextField.delegate = self
    }
    
    private func submitButton() {
        createView.submitButton.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
    }
    
    @objc private func submitTapped() {
        guard let userText = createView.userNameTextField.text else {return}
        if userText.isEmpty {
            createView.UserErrorLabel.text = "Pick a Username"
            createView.UserErrorLabel.isHidden = false
        } else {
        createView.UserErrorLabel.isHidden = true
        }
        
        guard let emailText = createView.emailTextField.text else {return}
        if emailText.isEmpty {
            createView.emailErrorLabel.text = "Email is empty"
            createView.emailErrorLabel.isHidden = false
        } else if !(emailText.contains("@") && emailText.contains(".")) {
            createView.emailErrorLabel.text = "Invalid email"
            createView.emailErrorLabel.isHidden = false
        } else {
            createView.emailErrorLabel.isHidden = true
        }
        
        guard let passwordText = createView.passwordTextField.text else {return}
        if passwordText.isEmpty {
            createView.invalidPasswordLabel.text = "No Password entered"
            createView.invalidPasswordLabel.isHidden = false
        } else if passwordText.count < 6 {
            createView.invalidPasswordLabel.text = "Password requires more than six characters"
        } else {
        createView.invalidPasswordLabel.isHidden = true
        }
        
        guard let confirmPassword = createView.passwordTextField.text else {return}
        if confirmPassword.isEmpty {
            createView.invalidConfirmLabel.text = "No Password entered"
            createView.invalidConfirmLabel.isHidden = false
        } else {
        createView.invalidConfirmLabel.isHidden = true
        }
        //TODO: Check for unique users
        if !passwordText.isEmpty && !createView.confirmPasswordTextField.text!.isEmpty {
        if passwordText == createView.confirmPasswordTextField.text {
            FirebaseUserManager.shared.createAccount(with: emailText, and: passwordText, username: userText) { (user, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
            }
            showAlert(title: "Account Created", message: "An email has been sent for authorization")
        } else {
            createView.invalidPasswordLabel.text = "Password's don't match"
            createView.invalidConfirmLabel.text = "Password's don't match"
            createView.invalidPasswordLabel.isHidden = false
            createView.invalidConfirmLabel.isHidden = false
            print("Passwords don't match!")
        }
      }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
            self.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil )
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
