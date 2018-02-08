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
        setupButtonActions()
        view.backgroundColor = .clear
        loginView.backgroundColor = .clear
        //turnRedAndShakeAnimation(view: loginView.containerView)
    }
    
}

// MARK: - Gestures
extension LoginVC {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view == loginView.blurView {
                dismiss(animated: true, completion: nil)
            } else {
                return
            }
        }
    }
    
}

// MARK: - Animations
extension LoginVC {
    private func turnRedAndShakeAnimation(view: UIView) {
        UIView.animate(withDuration: 1.0, animations: {
            view.frame.size.width += 10
            view.frame.size.height += 10
        }) { (done) in
            
            //
            UIView.animate(withDuration: 0.10, delay: 0.025, options: [.autoreverse, .allowUserInteraction], animations: {
                
                view.frame.origin.x += 10
            }, completion: { (done) in
                
            })
            //
            
            //
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.autoreverse, .allowUserInteraction], animations: {
                view.backgroundColor = .red
            }, completion: { (done) in
                
            })
            //
            
        }
    }
    
}

// MARK: - Haptics
extension LoginVC {
    private func successVibration() {
        let feedbackGen = UINotificationFeedbackGenerator()
        feedbackGen.prepare()
        feedbackGen.notificationOccurred(.success)
    }
    
    private func errorVibration() {
        let feedbackGen = UINotificationFeedbackGenerator()
        feedbackGen.prepare()
        feedbackGen.notificationOccurred(.error)
    }
    
    private func warningVibration() {
        let feedbackGen = UINotificationFeedbackGenerator()
        feedbackGen.prepare()
        feedbackGen.notificationOccurred(.warning)
    }
    
}

// MARK: - Button Actions
extension LoginVC {
    private func setupButtonActions() {
        loginView.submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        loginView.forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
        loginView.createNewAccountButton.addTarget(self, action: #selector(createNewAccountButtonTapped), for: .touchUpInside)
    }
    
    @objc private func submitButtonTapped() {
        // if successful log in, present success message and dismiss vc
        // else shake view and make red and prompt to verify info
        guard let usernameText = loginView.userNameTextField.text else { return }
        guard let passwordText = loginView.passwordTextField.text else { return }
        guard !usernameText.isEmpty else { return }
        guard !passwordText.isEmpty else { return }
        
        FirebaseUserManager.shared.login(with: usernameText, and: passwordText) { (user, error) in
            if let error = error {
                print(error)
            } else if let user = user {
                print("\(user) has logged in")
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @objc private func forgotPasswordButtonTapped() {
        // show alert controller and do firebase stuff
        let alertController = UIAlertController(title: "Alert", message: "Please enter your email address", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.autocorrectionType = .no
            textField.autocapitalizationType = .none
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        let submit = UIAlertAction(title: "Submit", style: .default) { (action) in
            if let textFields = alertController.textFields {
                if !textFields.isEmpty {
                    let textField = textFields[0]
                    guard let emailText = textField.text else { return }
                    guard !emailText.isEmpty else { return }
                    FirebaseUserManager.shared.forgotPassword(email: emailText)
                }
            }
        }
        alertController.addAction(cancel)
        alertController.addAction(submit)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func createNewAccountButtonTapped() {
        let createAccountVC = CreateAccountVC()
        createAccountVC.modalTransitionStyle = .crossDissolve
        createAccountVC.modalPresentationStyle = .overCurrentContext
        present(createAccountVC, animated: true, completion: nil)
    }
}
