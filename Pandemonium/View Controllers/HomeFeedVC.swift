//
//  HomeFeedVC.swift
//  
//
//  Created by C4Q on 1/30/18.
//

import UIKit
class HomeFeedVC: UIViewController,UIGestureRecognizerDelegate {
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
        let logo = #imageLiteral(resourceName: "parrot")
        let imageView = UIImageView(image:logo)
        imageView.contentMode = .scaleAspectFit
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(logoIconButtonItemAction))
        tap.delegate = self
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tap)
        self.navigationItem.titleView = imageView
        navigationItem.rightBarButtonItems = [listNavBarButtonItem, addPostNavBarButtonItem]
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedStringKey.foregroundColor: Settings.manager.textColor]
        navigationItem.title = "Pandemonium"
        navigationController?.navigationBar.barStyle = .black
        Settings.manager.navBarNightMode(navbar: navigationController!.navigationBar)
//        navigationController?.navigationBar.tintColor = Settings.manager.textColor
//        navigationController?.navigationBar.backgroundColor = Settings.manager.customBlue
    }
    //Load the list
    @objc func listNavBarButtonAction(){
        let menueViewController = MenuVC(safeArea: self.homeFeedView.safeAreaLayoutGuide)
        menueViewController.modalPresentationStyle = .overCurrentContext
        present(menueViewController, animated: true, completion: nil)
        //mark test function
        if let user = FirebaseUserManager.shared.getCurrentUser(){
            //TODO test the usersLoadPosts
            FirebasePostManager.manager.addPost(userUID: user.uid, date: "3516-35-23", title: "newOnew", tags: ["#kromp"], bodyText: nil, url: nil, image: nil, errorHandler: {print($0)})
//            FirebaseUserManager.shared.getParrotFrom(uid: user.uid, completionHandler: { (parrot) in
//                FirebasePostManager.manager.loadUserPosts(user: parrot, completionHandler: {print($0.first?.title)}, errorHandler: {print($0)})
//            }, errorHandler: {print($0)})
        }
    }
    @objc func addPostNavBarButtonAction(){
        if FirebaseUserManager.shared.getCurrentUser() == nil {
            present(LoginVC(), animated: true, completion: nil)
        }
        let createAPostVC = CreateAPostTableViewController.storyBoardInstance()
        createAPostVC.modalTransitionStyle = .crossDissolve
        createAPostVC.modalPresentationStyle = .overCurrentContext
        let navController = UINavigationController(rootViewController: createAPostVC)
        present(navController, animated: true, completion: nil)
    }
    @objc func logoIconButtonItemAction(_ sender: UITapGestureRecognizer){
        //TODO Make the app switch to the night mode
        if Settings.manager.logoPressed == false {
            Settings.manager.logoPressed = true
        } else {
            Settings.manager.logoPressed = false
        }
        Settings.manager.nightModeSwitch()
        self.homeFeedView.tableView.backgroundColor = Settings.manager.backgroundColor
        self.homeFeedView.tableView.reloadData()
        configNavBar()
        print("Dev: Logo has been pressed")
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
            instructionCell.backgroundColor = Settings.manager.backgroundColor
            instructionCell.textLabel?.numberOfLines = 0
            instructionCell.textLabel?.text = "Here are some rules for to help navigate through our app"
            instructionCell.textLabel?.font = Settings.manager.titleSize
            instructionCell.textLabel?.textColor = Settings.manager.textColor
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
            cell.tintColor = Settings.manager.textColor
            cell.backgroundColor = Settings.manager.backgroundColor
            return cell
        }
    }
}

// MARK: - tabelView Delegates
extension HomeFeedVC: UITableViewDelegate, HomeFeedTableViewCellDelegate{
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       
        let likeAction = UIContextualAction(style: .normal, title: "Like") { (action, view, handler) in
            if FirebaseUserManager.shared.getCurrentUser() == nil {
                self.present(LoginVC(), animated: true, completion: nil)
            }
            handler(true)
            print("Like Action Tapped")
        }
        likeAction.backgroundColor = .green
        let configuration = UISwipeActionsConfiguration(actions: [likeAction])
        configuration.performsFirstActionWithFullSwipe = true //HERE..
        return configuration
    }
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let dislikeAction = UIContextualAction(style: .normal, title: "Dislike") { (action, view, handler) in
            handler(true)
            if FirebaseUserManager.shared.getCurrentUser() == nil {
                self.present(LoginVC(), animated: true, completion: nil)
            }
            print("Dislike Action Tapped")
        }
        dislikeAction.backgroundColor = .red
        let configuration = UISwipeActionsConfiguration(actions: [dislikeAction])
        configuration.performsFirstActionWithFullSwipe = true //HERE..
        return configuration
    }
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let delete = UITableViewRowAction(style: .destructive, title: "delete") { (action, indexPath) in
//            // delete item at indexPath
//
//        }
//        let add = UITableViewRowAction(style: .normal, title: "add") { (action, indexPath) in
//            // add to favorites item at indexPath
//
//        }
//        add.backgroundColor = .green
//        return [delete, add]
//    }
    func upVoted(from tablVieCell: HomeFeedTableViewCell) {
        //TODO update the upVote for a post
        if let indexPath = tablVieCell.currentIndexPath{
            let postSetup = posts[indexPath.row-1]
            FirebasePostManager.manager.updatePostUpVote(for: postSetup)
        }
    }
    func downVoted(from tablVieCell: HomeFeedTableViewCell) {
        //TODO update the downVote for a post
        if let indexPath = tablVieCell.currentIndexPath{
            let postSetup = posts[indexPath.row-1]
            FirebasePostManager.manager.updatePostDownVote(for: postSetup)
        }
        
    }
    //This function will handle the action sheet for a specific user and give you the options to either report/viewProfile/Cancel
    func userNameSelected(from tablViewCell: HomeFeedTableViewCell) {
        if let indexPath = tablViewCell.currentIndexPath{
            let postSetup = self.posts[indexPath.row - 1]
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            let reportAction = UIAlertAction(title: "Report", style: .default, handler: { (action) in
                self.getReportAlert()
            })
            let userProfileAction = UIAlertAction(title: "View Profile", style: .default, handler: { (action) in
                //TODO Inject the User to the profileViewController
                let profileViewController = ProfileViewController()
                self.navigationController?.pushViewController(profileViewController, animated: true)
            })
            actionSheet.addAction(reportAction)
            actionSheet.addAction(userProfileAction)
            actionSheet.addAction(cancelAction)
            present(actionSheet, animated: true, completion: nil)
            
        }
    }
    //This function will give you alert with textField where user can enter more information about the report
    func getReportAlert(){
        let reportAlert = UIAlertController(title: "Report User", message: "Please enter more information", preferredStyle: .alert)
        let reportOKAction = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
            //TODO Send report to Houston
            print(reportAlert.textFields?.first?.text)
        })
        let reportCancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        reportAlert.addTextField { (textField) in
            textField.placeholder = "ex: Improper Content, Violence"
        }
        reportAlert.addAction(reportOKAction)
        reportAlert.addAction(reportCancelAction)
        self.present(reportAlert, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row != 0 else{
            return
        }
        let detailedPostViewController = DetailPostVC(post: posts[indexPath.row - 1])
        navigationController?.pushViewController(detailedPostViewController, animated: true)
    }
}

//Mark:  - TableView Cell setup
extension HomeFeedVC{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = UIScreen.main.bounds.height*0.20
        return cellHeight
    }
}









