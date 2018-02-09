//
//  LoginView.swift
//  
//
//  Created by C4Q on 1/30/18.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        //view.clipsToBounds = true
        view.layer.cornerRadius = 20
        view.layer.shadowOpacity = 0.8
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        return view
    }()
    
    var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        return label
    }()
    
    var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.layer.shadowOpacity = 0.8
        textField.layer.shadowOffset = CGSize(width: 2, height: 2)
        textField.keyboardType = .emailAddress
        return textField
    }()
    
    var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        return label
    }()
    
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.layer.shadowOpacity = 0.8
        textField.layer.shadowOffset = CGSize(width: 2, height: 2)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Forgot password?", for: .normal)
        return button
    }()
    
    var submitButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("   Submit   ", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.8
        button.layer.shadowOffset = CGSize(width: 2, height: 2)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return button
    }()
    
    var createNewAccountButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Create new account", for: .normal)
        return button
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
        setupBlurView()
        setupContainerView()
        setupUserNameLabel()
        setupUserNameTextField()
        setupPasswordLabel()
        setupPasswordTextField()
        setupForgotPasswordButton()
        setupSubmitButton()
        setupCreateNewAccountButton()
    }
    
    
}

// MARK: - Setup Views
extension LoginView {
    private func setupBlurView() {
        blurView.frame = bounds
        addSubview(blurView)
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.50)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.80)
            make.center.equalTo(safeAreaLayoutGuide.snp.center)
        }
    }
    
    private func setupUserNameLabel() {
        containerView.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.top.equalTo(containerView.snp.top).offset(16)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
        }
    }
    
    private func setupUserNameTextField() {
        containerView.addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(userNameLabel.snp.bottom).offset(4)
            make.leading.equalTo(userNameLabel.snp.leading)
            make.width.equalTo(userNameLabel.snp.width)
        }
    }
    
    private func setupPasswordLabel() {
        containerView.addSubview(passwordLabel)
        passwordLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userNameTextField.snp.bottom).offset(8)
            make.leading.equalTo(userNameLabel.snp.leading)
            make.width.equalTo(userNameLabel.snp.width)
        }
    }
    
    private func setupPasswordTextField() {
        containerView.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(passwordLabel.snp.bottom).offset(4)
            make.leading.equalTo(userNameLabel.snp.leading)
            make.width.equalTo(userNameLabel.snp.width)
        }
    }
    
    private func setupForgotPasswordButton() {
        containerView.addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(2)
            make.leading.equalTo(userNameLabel.snp.leading)
        }
    }
    
    private func setupSubmitButton() {
        containerView.addSubview(submitButton)
        submitButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(containerView.snp.centerX)
            make.top.equalTo(forgotPasswordButton.snp.bottom).offset(40)
        }
    }
    
    private func setupCreateNewAccountButton() {
        containerView.addSubview(createNewAccountButton)
        createNewAccountButton.snp.makeConstraints { (make) in
            make.leading.equalTo(userNameLabel.snp.leading)
            make.bottom.equalTo(containerView.snp.bottom).offset(-8)
        }
    }
}
