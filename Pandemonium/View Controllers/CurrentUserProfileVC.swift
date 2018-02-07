//
//  CurrentUserProfileVC.swift
//  
//
//  Created by C4Q on 1/30/18.
//

import UIKit

class CurrentUserProfileVC: UIViewController {
    
    let profileView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureProfileView()
        view.backgroundColor = .cyan
    
    }
    
    func configureProfileView(){
        self.view.addSubview(profileView)
        profileView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        self.profileView.tableView.dataSource = self
        self.profileView.tableView.delegate = self
    }
}

//MARK: TableView Datasource
extension CurrentUserProfileVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        //return user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            //dequee currentUserCell
            let profileCell = tableView.dequeueReusableCell(withIdentifier: "currentUserImageCell") as! CurrentUserTableViewCell
            
//            func nameEditButtonPressed(){
//                //TODO: hide name label and present textfield
//                //In should return, set text to label.text and hide textfield
//            }
//            
//            profileCell.userNameEditButton.addTarget(self, action: #selector(nameEditButtonPressed), for: .touchUpInside)
          
            profileCell.userNameTextField.backgroundColor = .red
            return profileCell
        }
        
        let profilePostCell = tableView.dequeueReusableCell(withIdentifier: "profilePostCell") as! ProfilePostCustomTableViewCell
        return profilePostCell
    }
}

//MARK: TableView Delegates
extension CurrentUserProfileVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0{
            return UIScreen.main.bounds.height * 0.45
        }else{
            return UIScreen.main.bounds.height * 0.20
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {}
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {}
}
