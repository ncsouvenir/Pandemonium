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

    }

}

// MARK: - Gestures
extension LoginVC {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view == loginView.blurView {
                // TODO: - Dismiss login view controller and go back to previous vc
                print("yaayayayaayaya")
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
            view.backgroundColor = .red
            
            
        }) { (done) in
            
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
    }
    
    @objc private func forgotPasswordButtonTapped() {
        // show alert controller and do firebase stuff
    }
    
    @objc private func createNewAccountButtonTapped() {
        // segue to create account vc
    }
}
