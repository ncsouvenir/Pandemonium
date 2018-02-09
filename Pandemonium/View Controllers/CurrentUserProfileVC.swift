//
//  CurrentUserProfileVC.swift
//  
//
//  Created by C4Q on 1/30/18.
//

import UIKit
import AVFoundation


class CurrentUserProfileVC: UIViewController {
    
    let profileView = ProfileView()
    let homeFeedVC = HomeFeedVC()
    let currentUserCustomCell = CurrentUserProfileImageCustomTableViewCell()
    var imagePickerView = UIImagePickerController()
    var indexPathForImage = IndexPath()
    var user: Parrot?{
        didSet{
            //loadUserPosts()
            profileView.tableView.reloadData()
        }
    }
    
    //    var posts = [Post](){
    //        didSet{
    //            profileView.tableView.reloadData()
    //        }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureProfileView()
        configureNavBar()
        FirebaseUserManager.shared.getParrotFrom(uid: (FirebaseUserManager.shared.getCurrentUser()!.uid),
                                                 completionHandler: {self.user = $0},
                                                 errorHandler: {print("Dev:",$0)})}
    
    //    func loadUserPosts(){
    //        guard let user = user else {
    //            return
    //        }
    //        FirebasePostManager.manager.loadUserPosts(user: user,
    //                                                  completionHandler: {self.posts = $0},
    //                                                  errorHandler: {print($0)})}
    private func configureNavBar() {
        let leftNavBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(dismissCurrentUserProfileVC))
        navigationItem.leftBarButtonItem = leftNavBarButtonItem
        navigationItem.title = "Profile"
    }
    
    @objc private func dismissCurrentUserProfileVC() {
        //dismiss(animated: true, completion: nil)
     self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        //homeFeedVC.dismiss(animated: true, completion: nil)
    }
    
    func configureProfileView(){
        self.view.addSubview(profileView)
        profileView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        profileView.tableView.dataSource = self
        profileView.tableView.delegate = self
        imagePickerView.delegate = self
    }
    
    //MARK ACTIONSHEET : Add Image button pressed
    private func editImageOptions(){
        // 1
        let addImageMenu = UIAlertController(title: nil, message: "How would you like to add your image?", preferredStyle: .actionSheet)
        // 2
        let accessCameraAction = UIAlertAction(title: "Camera", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("user accessed camera")
            //TODO: action to access phone camera
            self.showCamera()
        })

        let accessPhotoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("user pressed photo library")
            //TODO: action to access photo library
            self.showPhotoLibrary()
        })

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        // 3
        addImageMenu.addAction(accessCameraAction)
        addImageMenu.addAction(accessPhotoLibraryAction)
        addImageMenu.addAction(cancelAction)
        // 4
        self.present(addImageMenu, animated: true, completion: nil)
    }

    private func showPhotoLibrary() {
        imagePickerView.sourceType = .photoLibrary
        checkAVAuthorization()
    }

    private func showCamera() {
        imagePickerView.sourceType = .camera
        checkAVAuthorization()
    }

    private func checkAVAuthorization() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            print("notDetermined")
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted) in
                if granted {
                    self.showImagePicker()
                } else {
                    print("not granted")
                }
            })
        case .denied:
            print("denied")
        case .authorized:
            print("authorized")
            showImagePicker()
        case .restricted:
            print("restricted")
        }
    }

    private func showImagePicker() {
        present(imagePickerView, animated: true, completion: nil)
    }

    //MARK ACTIONSHEET : long press gesture on post cell
    private func configureEditPostActionSheet(){
        // 1
        let addMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // 2
        let editPostAction = UIAlertAction(title: "Edit Post", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Edit button pressed")
            //TODO: segue to Edit Post VC
            let editPostVC = UserEditPostTableViewController.storyBoardInstance()
            let navController = UINavigationController(rootViewController: editPostVC)
            self.present(navController, animated: true, completion: nil)
            print("cell long pressed")
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("user pressed cancel")
        })
        // 3
        addMenu.addAction(editPostAction)
        addMenu.addAction(cancelAction)
        // 4
        self.present(addMenu, animated: true, completion: nil)
    }
}

//MARK: TableView Datasource
extension CurrentUserProfileVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        //return (1 + posts.count)
        //        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            //dequee currentUserCell
            let profileCell = tableView.dequeueReusableCell(withIdentifier: "currentUserImageCell") as! CurrentUserProfileImageCustomTableViewCell
            //4 setting the delegate
            profileCell.userNameLabel.text = user?.appUserName
            profileCell.delegate = self
            profileCell.indexPath = indexPath
            profileCell.userNameTextField.backgroundColor = .black
            return profileCell
        }
        //let post = posts[indexPath.row]
        let profilePostCell = tableView.dequeueReusableCell(withIdentifier: "currentUserProfilePostCell") as! CurrentUserProfilePostCustomCustomTableViewCell
        //4 setting the delegate
        profilePostCell.delegate = self
        profilePostCell.indexPath = indexPath
        //profilePostCell.configureUserPostCell(from: post)
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //TODO: segue to detail post VC
        let detailPostVC = DetailPostVC()
        detailPostVC.modalTransitionStyle = .crossDissolve
        detailPostVC.modalPresentationStyle = .overCurrentContext
        self.present(detailPostVC, animated: true, completion: nil)
    }
}

///// MARK: TextField Delegate: in the custom cell file /////


//MARK: 5. Custom Image Cell Delegates
extension CurrentUserProfileVC: CurrentUserProfileImageTableViewCellDelegate{
    
    func didEditUserName(_ tableViewCell: CurrentUserProfileImageCustomTableViewCell) {
        self.indexPathForImage = tableViewCell.indexPath
        let cell = profileView.tableView.cellForRow(at: self.indexPathForImage) as! CurrentUserProfileImageCustomTableViewCell
        cell.userNameTextField.isHidden = false
    }
    
    func didEditProfileImage(_ tableViewCell: CurrentUserProfileImageCustomTableViewCell) {
        self.indexPathForImage = tableViewCell.indexPath
        editImageOptions()
    }
}

//MARK: 5. Custom Post Cell Delegates
extension CurrentUserProfileVC: CurrentUserProfilePostCustomCustomTableViewCellDelegate{
    
    func didUseLongPressGesture(_ tableViewCell: CurrentUserProfilePostCustomCustomTableViewCell) {
        configureEditPostActionSheet()
    }
}


//MARK: Configuring Photo Library
extension CurrentUserProfileVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { print("image is nil"); return }
        
        let cell = profileView.tableView.cellForRow(at: self.indexPathForImage) as! CurrentUserProfileImageCustomTableViewCell
        cell.profileImage.image = image
        
        
        // resize the image
        //        let sizeOfImage: CGSize = CGSize(width: 200, height: 200)
        //        let toucanImage = Toucan.Resize.resizeImage(image, size: sizeOfImage)
        //
        //currentSelectedImage = toucanImage
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

