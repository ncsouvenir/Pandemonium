//
//  HomeFeedVC.swift
//  
//
//  Created by C4Q on 1/30/18.
//

import UIKit
class HomeFeedVC: UIViewController {

    var posts = [Post](){
        didSet{
            self.homeFeedView.tableView.reloadData()
        }
    }
    let homeFeedView = HomeFeedView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHomeFeedView()
        configNavBar()
        //tableViewDelegates
        self.homeFeedView.tableView.dataSource = self
        self.homeFeedView.tableView.delegate = self
        loadPosts()
    }
    func loadPosts(){
        FirebasePostManager.manager.loadPosts { (posts, error) in
            if let error = error{
                print(error)
            }else if let posts = posts{
                self.posts = posts
            }
        }
    }
    func configNavBar(){
        let listNavBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "list"), style: .plain, target: self, action: #selector(listNavBarButtonAction))
        let addPostNavBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus-symbol"), style: .plain, target: self, action: #selector(addPostNavBarButtonAction))
        let logoIconButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "compass_background"), style: .done, target: self, action: #selector(logoIconButtonItemAction))
        logoIconButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = logoIconButtonItem
        navigationItem.rightBarButtonItems = [listNavBarButtonItem, addPostNavBarButtonItem]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Pandemonium"
        navigationController?.navigationBar.backgroundColor = .orange
    }
    @objc func listNavBarButtonAction(){
        //TODO Load the list
        //MarkTest ProfileViewController
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
    }
    @objc func addPostNavBarButtonAction(){
        //TODO Load the Add Post ViewController
                FirebasePostManager.manager.addPosts()
    }
    @objc func logoIconButtonItemAction(){
        //TODO Make the app switch to the night mode
    }
    
    func setupHomeFeedView(){
        view.addSubview(homeFeedView)
        homeFeedView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
}

// MARK: - tabelView DataSource
extension HomeFeedVC:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count+1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //instruction cell setup
        if indexPath.row == 0{
            let instructionCell = UITableViewCell()
            instructionCell.textLabel?.text = "Here is some instruction two how things going"
            return instructionCell
        }
            //post cell setup
        else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCell") as? HomeFeedTableViewCell else{
                return UITableViewCell()
            }
            cell.delegate = self
            cell.currentIndexPath = indexPath
            let postSetup = posts[indexPath.row-1]
            cell.setupCell(with: postSetup)
            return cell
        }
    }
}

// MARK: - tabelView Delegates
extension HomeFeedVC: UITableViewDelegate, HomeFeedTableViewCellDelegate{
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .destructive, title: "delete") { (action, indexPath) in
            // delete item at indexPath

        }
        let add = UITableViewRowAction(style: .normal, title: "add") { (action, indexPath) in
            // add to favorites item at indexPath

        }
        add.backgroundColor = .green
        return [delete, add]
    }
    func upVoted(from tablVieCell: HomeFeedTableViewCell) {
        //TODO update the upVote for a post
        if let indexPath = tablVieCell.currentIndexPath{
            let postSetup = posts[indexPath.row-1]
            FirebasePostManager.manager.updatePostUpVote(for: postSetup)
        }
        print("delegate fired")
    }
    func downVoted(from tablVieCell: HomeFeedTableViewCell) {
        //TODO update the downVote for a post
        if let indexPath = tablVieCell.currentIndexPath{
            let postSetup = posts[indexPath.row-1]
            FirebasePostManager.manager.updatePostDownVote(for: postSetup)
        }
        print("delegate fired")
    }
}

//Mark:  - TableView Cell setup
extension HomeFeedVC{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = UIScreen.main.bounds.height*0.20
        return cellHeight
    }
}









