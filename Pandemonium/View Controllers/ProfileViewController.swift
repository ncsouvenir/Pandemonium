//
//  ProfileViewController.swift
//  
//
//  Created by C4Q on 1/30/18.
//

import UIKit

class ProfileViewController: UIViewController {
//    let user: Parrot
//    init(user: Parrot){
//    self.user = user
//        super.init(nibName: nil, bundle: nil)
//    }

//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
    let profileView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProfileView()
        setupNavigationBar()
        
        // Do any additional setup after loading the view.
    }
    
    func setupNavigationBar(){
//        navigationItem.title = "John Jack Jones"
        
    }
    func setupProfileView(){
        self.view.addSubview(profileView)
        profileView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        self.profileView.tableView.dataSource = self
        self.profileView.tableView.delegate = self
    }

    
}

extension ProfileViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return (self.user?.posts.count + 1)
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let profileCell = tableView.dequeueReusableCell(withIdentifier: "profileImageCell") as! ProfileImageCustomTableViewCell
            return profileCell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "profilePostCell", for: indexPath) as! ProfilePostCustomTableViewCell
        return cell
    }
    
    
}
extension ProfileViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return UIScreen.main.bounds.height*0.45
        }else{
            return UIScreen.main.bounds.height*0.20
        }
    }
    
}

