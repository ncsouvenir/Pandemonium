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
        
    
    var currentUserCustomCell = CurrentUserProfileImageCustomTableViewCell()

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
        menuView.signInButton.addTarget(self, action: #selector(segueToSignIn), for: .touchUpInside)
        menuView.signOutButton.addTarget(self, action: #selector(signOutAction), for: .touchUpInside)
        menuView.profileButton.addTarget(self, action: #selector(segueToProfile), for: .touchUpInside)
        menuView.homeButton.addTarget(self, action: #selector(exit), for: .touchUpInside)
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
        let alertViewController = UIAlertController(title: "Thank You, come again!", message: "", preferredStyle: UIAlertControllerStyle.alert)

        let alertAction = UIAlertAction(title: "OK", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            //dismiss menuVC and take back to HomeFeed
            self.dismiss(animated: true, completion: nil)
        })
        alertViewController.addAction(alertAction)
        present(alertViewController, animated: true, completion: nil)
    }
    
    @objc func segueToProfile() {
        if FirebaseUserManager.shared.getCurrentUser() == nil {
            present(LoginVC(), animated: true, completion: nil)
        }else{
            let currentUserProfileVC = CurrentUserProfileVC()
            let navController = UINavigationController(rootViewController: currentUserProfileVC)
            present(navController, animated: true, completion: {
            })
            print(user)
        }
    }
    
    @objc func segueToCreateAccount(){
        //TODO: segue to the create account
        let createAccountViewController = CreateAccountVC()
        present(createAccountViewController, animated: true, completion: nil)
    }
}
