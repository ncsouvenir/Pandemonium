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
            //TODO update the tableView with the data provided
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
    }
    func configNavBar(){
        let listNavBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "list"), style: .plain, target: self, action: nil)
        let addNavBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "plus-symbol"), style: .plain, target: self, action: nil)
        let logoIconButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "compass_background"), style: .done, target: self, action: nil)
        logoIconButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = logoIconButtonItem
        navigationItem.rightBarButtonItems = [listNavBarButtonItem, addNavBarButtonItem]
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Pandemonium"
        navigationController?.navigationBar.backgroundColor = .orange
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //instruction cell setup
        if indexPath.row == 0{
            let instructionCell = UITableViewCell()
            instructionCell.textLabel?.text = "Here is some instruction two how things going"
            instructionCell.detailTextLabel?.text = "you can post and up and down stuff"
            return instructionCell
        }
            //post cell setup
        else{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "customTableViewCell") as? HomeFeedTableViewCell else{
                return UITableViewCell()
            }
            cell.postTitle.text = "New Post"
            return cell
        }
    }
}

// MARK: - tabelView Delegates
extension HomeFeedVC: UITableViewDelegate{
}

//Mark:  - TableView Cell setup
extension HomeFeedVC{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellHeight = UIScreen.main.bounds.height * 0.15
        return cellHeight
    }
}








