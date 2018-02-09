//
//  UserEditPostTableViewController.swift
//  Pandemonium
//
//  Created by C4Q on 2/7/18.
//  Copyright © 2018 C4Q. All rights reserved.
//

import UIKit
import Firebase
import AVFoundation

class UserEditPostTableViewController: UITableViewController {
    
    
    @IBOutlet weak var ImageCell: UITableViewCell!
    @IBOutlet weak var linkCell: UITableViewCell!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var tagsTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var bodytextView: UITextView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var detailedImageView = CreatePostSelectedImageView()
    var createAPostVC = CreateAPostTableViewController()
    private let imagePickerView = UIImagePickerController()
    
    var post: Post!
    
    init(userPost: Post){
        super.init(nibName: nil, bundle: nil)
        self.post = userPost
        createAPostVC.configureEditPostVC(with: userPost)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {//
        super.init(nibName: nibNameOrNil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder){// required becuase subclassing
        super.init(coder: aDecoder)
    }
    
    //    override func viewDidAppear(_ animated: Bool) {
    //        super.viewDidAppear(true)
    //        imagePickerView.delegate = self
    //              configureTextFieldDelegates()
    //        configureNavBar()
    //        configureImageButton()
    //        configureSegmentedControl()
    //        //2
    //        segmentedControl.addUnderlineForSelectedSegment()
    //        configureImageGesture()
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerView.delegate = self
        configureTextFieldDelegates()
        configureNavBar()
        configureImageButton()
        configureSegmentedControl()
        //2
        segmentedControl.addUnderlineForSelectedSegment()
        configureImageGesture()
        
        populateFields()
        
        //        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
        //            cameraButtonItem.isEnabled = false
        //        }
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        //TODO: add alert Controller
        
        let alertController = UIAlertController(title: "Absolutely Sure?",
                                                message:"Final call before post is deleted",
                                                preferredStyle: UIAlertControllerStyle.alert)
        
        let deleteAction = UIAlertAction(title: "Delete Post", style: UIAlertActionStyle.default){(post) in
            //TODO: removes post from Firebase which should delete it everywhere else in the app
            //FirebasePostManager.manager.deletePost()
            //TODO: alert notifiying user of deletion
            let alertController = UIAlertController(title: "Gone!",
                                                    message:"Post was deleted",
                                                    preferredStyle: UIAlertControllerStyle.alert)
            
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){deletedPost in
              FirebasePostManager.manager.deletePost(post: self.post)
                
            }
            alertController.addAction(okAction)
            //present alert controller
            self.present(alertController, animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default)
        //for other actions add in actions incompletion{}
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        //present alert controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func configureImageGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer){
        //TODO: use dependency injection to pass Image Object to PresentLargeVC
        //-> passing anything that the destination VC needs
        //setting up what the modal presentation will look like
        
        //connecting the imageView to the image selected from photo library
        var selectedImage = UIImage()
        if let image = imageView.image {
            selectedImage = image //image is nil here
        } else {
            selectedImage = UIImage(named: "noImg")!
        }
        
        let presentCreatePostSelectedImageVC = CreatePostSelectedImageVC(selectedImage: selectedImage)
        presentCreatePostSelectedImageVC.modalTransitionStyle = .crossDissolve
        presentCreatePostSelectedImageVC.modalPresentationStyle = .overCurrentContext
        
        present(presentCreatePostSelectedImageVC, animated: true, completion: nil)
        print("image tapped")
    }
    private func populateFields() {
        if let post = post {
            FirebaseUserManager.shared.getUsernameFromUID(uid: post.userUID, completionHandler: {
                self.userNameTextField.text = $0
            }, errorHandler: { print($0) })
            titleTextField.text = post.title
            tagsTextField.text = post.tags.joined(separator: " ")
            urlTextField.text = post.url ?? ""
            bodytextView.text = post.bodyText ?? ""
            if let postImage = post.image {
                FirebaseStorageManager.shared.retrieveImage(imgURL: postImage, completionHandler: {
                    self.imageView.image = $0
                }, errorHandler: { print($0) })
            }
        }
    }
    
    private func configureTextFieldDelegates() {
        //userNameTextField.delegate = self
        titleTextField.delegate = self
        tagsTextField.delegate = self
        urlTextField.delegate = self
        bodytextView.delegate = self
    }
    
    private func configureImageButton() {
        addImageButton.layer.borderWidth = 2
        addImageButton.layer.borderColor = UIColor.black.cgColor
        addImageButton.layer.cornerRadius = addImageButton.bounds.width / 8.0
        addImageButton.layer.masksToBounds = true
    }
    
    private func configureSegmentedControl() {
        //changing segmented controller font size
        let font = UIFont.systemFont(ofSize: 17, weight: .medium)
        segmentedControl.setTitleTextAttributes([NSAttributedStringKey.font: font], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.red], for: .normal)
    }
    
    private func configureNavBar(){
        navigationItem.title = "Edit A Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(sendButtonPressed))
    }
    
    
    //MARK: Bar Button Actions
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func sendButtonPressed(){
        let currentUserProfileVC = CurrentUserProfileVC()
        currentUserProfileVC.modalTransitionStyle = .crossDissolve
        currentUserProfileVC.modalPresentationStyle = .overCurrentContext
        present(currentUserProfileVC, animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
        resignFirstResponder()
    }
    
    //MARK: segmented control button pressed
    @IBAction func segmentedControlIndexPressed(_ sender: UISegmentedControl) {
        //TODO: when user clicks on image or url, it will unhide the hidden cell
        //1
        segmentedControl.changeUnderlinePosition()
        self.tableView.reloadData()
    }
    
    @IBAction func addImageButtonPressed(_ sender: UIButton) {
        //TODO: show action sheet to select image from camera rool or photo library
        configureAddImageOptions()
    }
    
    //MARK ACTIONSHEET : Add Image button pressed
    private func configureAddImageOptions(){
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
            print("user pressed cancel")
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
    
    //MARK: Making a storyBoard instance to call in the AppDelegate
    public static func storyBoardInstance() -> UserEditPostTableViewController {
        let storyboard = UIStoryboard(name: "UserEditPost", bundle: nil)//storyBoard File Name
        let editAPostVC = storyboard.instantiateViewController(withIdentifier: "UserEditPostTableViewController") as! UserEditPostTableViewController //name of ViewController File
        return editAPostVC
    }
    
    //MARK: - Tableview delegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //hiding and showing link cell
        if indexPath.row == 5 && segmentedControl.selectedSegmentIndex != 0{
            return 0.0
        } else if indexPath.row == 5 && segmentedControl.selectedSegmentIndex == 0 {
            return 60.0
        }
        
        //hiding and showing image cell
        if indexPath.row == 4 && segmentedControl.selectedSegmentIndex != 2{
            return 0.0
        } else if indexPath.row == 4 && segmentedControl.selectedSegmentIndex == 2 {
            return 80.0
        }
        
        //set bodyView to fill space between other textfields and delete button
        if indexPath.row == 6 && segmentedControl.selectedSegmentIndex == 0 {
            return view.bounds.height - 420
        } else if indexPath.row == 6 && segmentedControl.selectedSegmentIndex == 1{
            return view.bounds.height - 365
        } else if indexPath.row == 6 && segmentedControl.selectedSegmentIndex == 2{
            return view.bounds.height - 440
        }
        return 60.0
    }
}

//MARK: TextField Delegates
extension UserEditPostTableViewController: UITextFieldDelegate {
    
    //Did Begin Editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        textField.becomeFirstResponder()
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //guard let text = textField.text else {return true}
        
        //TODO bring up and resign keyboard for each text field
        guard let userName = userNameTextField.text else {print("textField is empty");return false}
        guard let title = titleTextField.text else {print("textField is empty");return false}
        guard let tags = tagsTextField.text else {print("textField is empty");return false}
        guard let urlStr = urlTextField.text else {print("enter a valid url");return false}
        
        //MARK: handling for each textField
        if textField == userNameTextField{
            if userName == "" {
                textFieldEmptyAlert()
                
            } else {
                textField.resignFirstResponder()
            }
        }
        
        if textField == titleTextField{
            if title == ""{
                textFieldEmptyAlert()
            } else {
                textField.resignFirstResponder()
            }
        }
        
        if textField == tagsTextField{
            if tags == "" {
                textFieldEmptyAlert()
            } else {
                textField.resignFirstResponder()
            }
        }
        
        //MARK: handling for vaild url string in urlTextField
        if textField == urlTextField {
            let isValid = isValidUrl(url: urlStr)
            if isValid{
                textField.resignFirstResponder()
            }else{
                textFieldEmptyAlert()
            }
        }
        textField.resignFirstResponder()
        return true
    }
    
    //MARk: checking validity of urlStr
    func isValidUrl(url: String) -> Bool {
        let urlRegEx = "(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+"
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
        let result = urlTest.evaluate(with: url)
        return result
    }
    
    func textFieldEmptyAlert(){
        let alertController = UIAlertController(title: "Required",
                                                message:"Please enter a valid entry",
                                                preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

//MARK: TextView Delegates
extension UserEditPostTableViewController: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        let topLeftPoint = CGPoint(x: 0, y: -100) //TO DO: ID Behavior
        tableView.setContentOffset(topLeftPoint, animated: false)
        print("done editing")
    }
}


//MARK: Configuring Photo Library
extension UserEditPostTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { print("image is nil"); return }
        imageView.image = image
        
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
