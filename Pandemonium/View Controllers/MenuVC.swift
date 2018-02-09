//
//  MenuVC.swift
//  Pandemonium
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit

class MenuVC: UIViewController, UIGestureRecognizerDelegate {
    
    var user: Parrot!

    var safeArea: UILayoutGuide
     init(safeArea: UILayoutGuide) {
        self.safeArea = safeArea
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let menuView = MenuView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillLayoutSubviews() {
        seutupBackgroundView()
        setupMenuView()
    }
    func seutupBackgroundView(){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.layer.opacity = 0.75
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(self.safeArea.snp.top)
            constraint.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            constraint.width.equalTo(view.safeAreaLayoutGuide.snp.width)
            constraint.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
        let tap = UITapGestureRecognizer(target: self, action: #selector(exit))
        tap.delegate = self
        blurEffectView.isUserInteractionEnabled = true
        blurEffectView.addGestureRecognizer(tap)
    }
    
    func setupMenuView(){
        view.addSubview(menuView)
        menuView.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(self.safeArea.snp.top)
            constraint.right.equalTo(view.safeAreaLayoutGuide.snp.right)
            constraint.width.equalTo(view.safeAreaLayoutGuide.snp.width).multipliedBy(0.50)
            constraint.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
//        menuView.exitButton.addTarget(self, action: #selector(exit), for: .touchUpInside)
        menuView.signInButton.addTarget(self, action: #selector(segueToSignIn), for: .touchUpInside)
        menuView.signOutButton.addTarget(self, action: #selector(signOutAction), for: .touchUpInside)
        menuView.profileButton.addTarget(self, action: #selector(segueToProfile), for: .touchUpInside)
        menuView.homeButton.addTarget(self, action: #selector(exit), for: .touchUpInside)
//        menuView.createNewAccount.addTarget(self, action: #selector(segueToCreateAccount), for: .touchUpInside)
    }
    //this method will exit the menue
    @objc func exit(){
        self.dismiss(animated: false, completion: nil)
    }
    //this function will lead you to the loginVC
    @objc func segueToSignIn(){
        let loginVC = LoginVC()
        present(loginVC, animated: true, completion: nil)
    }
    //this function will sign you out
    @objc func signOutAction(){
        FirebaseUserManager.shared.logOut()
        let alertViewController = UIAlertController(title: "You are sign out", message: "", preferredStyle: UIAlertControllerStyle.alert)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertViewController.addAction(alertAction)
        present(alertViewController, animated: true, completion: nil)
    }
    
    @objc func segueToProfile(){
        if FirebaseUserManager.shared.getCurrentUser() == nil {
            present(LoginVC(), animated: true, completion: nil)
        }else{
            let currentUserProfileVC = CurrentUserProfileVC()
                    currentUserProfileVC.modalPresentationStyle = .overCurrentContext
                    currentUserProfileVC.modalTransitionStyle = .crossDissolve
            present(currentUserProfileVC, animated: true, completion: nil)
        }
        //self.present(CurrentUserProfileVC(), animated: true, completion: nil)
    

//
//
//        let alertViewController = UIAlertController(title: "Your aren't signed in please sign in ", message: "", preferredStyle: UIAlertControllerStyle.alert)
//        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
//        alertViewController.addAction(alertAction)
//        present(alertViewController, animated: true, completion: nil)
        
    }
    @objc func segueToCreateAccount(){
        //TODO: segue to the create account
        let createAccountViewController = CreateAccountVC()
        present(createAccountViewController, animated: true, completion: nil)
    }
}
