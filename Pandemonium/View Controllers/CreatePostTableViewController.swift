//
//  CreatePostTableViewController.swift
//  Pandemonium
//
//  Created by C4Q on 2/6/18.
//  Copyright © 2018 C4Q. All rights reserved.
//
import UIKit
import Firebase
import AVFoundation

class CreateAPostTableViewController: UITableViewController {
    
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
    
    
    var detailedImageView = CreatePostSelectedImageView()
    private let imagePickerView = UIImagePickerController()
    
    
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
        
        //        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
        //            cameraButtonItem.isEnabled = false
        //        }
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
        var largeDetailImage = UIImage()
        
        if let image = imageView.image {
            
            largeDetailImage = image //image is nil here
        } else {
            largeDetailImage = #imageLiteral(resourceName: "noImg")//UIImage(named: "placeholder-image")
        }
        
        let presentImageVC = CreatePostSelectedImageVC(largeImageView: #imageLiteral(resourceName: "editPencil"))
        presentImageVC.modalTransitionStyle = .crossDissolve
        presentImageVC.modalPresentationStyle = .overCurrentContext
        
        present(presentImageVC, animated: true, completion: nil)
        print("image tapped")
    }
    
    private func configureTextFieldDelegates() {
        userNameTextField.delegate = self
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
        navigationItem.title = "Create A Post"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Send", style: .plain, target: self, action: #selector(sendButtonPressed))
    }
    
    
    //MARK: Bar Button Actions
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func sendButtonPressed(){
        //TODO: call FirebasePostManager.manager.addPosts() to populate the new post in the HomeFeed VC
        let currentUser = FirebaseUserManager.shared.getCurrentUser()!
        FirebasePostManager.manager.addPost(userUID: currentUser.uid, date: Date().description, title: titleTextField.text!, tags: ["#BANANA", "#NATE SUX"], bodyText: bodytextView.text, url: urlTextField.text, image: imageView.image)
        //TODO: alert to notify user that the post was added
        dismiss(animated: true, completion: nil)
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
    public static func storyBoardInstance() -> CreateAPostTableViewController {
        let storyboard = UIStoryboard(name: "CreateAPost", bundle: nil)//storyBoard File Name
        let createAPostVC = storyboard.instantiateViewController(withIdentifier: "CreateAPostTableViewController") as! CreateAPostTableViewController //name of ViewController File
        return createAPostVC
        
        //TODO: in HomeFeed VC, the plus button should segue over to the Create A Post VC
        
        /*
         let createAPostVC = CreateAPostTableViewController.storyBoardInstance()
         createAPostVC.modalTransitionStyle = .crossDissolve
         createAPostVC.modalPresentationStyle = .overCurrentContext
         let navController = UINavigationController(rootViewController: createAPostVC)
         present(navController, animated: true, completion: nil)*/
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
        
        //set bodyView to fill the rest of the VC
        if indexPath.row == 6 {
            return view.bounds.height - 330
        }
        return 60.0
    }
}

//MARK: TextField Delegates
extension CreateAPostTableViewController: UITextFieldDelegate {
    
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
        //for other actions add in actions incompletion{}
        alertController.addAction(okAction)
        //present alert controller
        self.present(alertController, animated: true, completion: nil)
    }
}

//MARK: TextView Delegates
extension CreateAPostTableViewController: UITextViewDelegate {
    
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
extension CreateAPostTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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




/////////////////////////////////////MARK: this will remove the the border from the segmented control and add an underline for the selected segment
//inspiration: https://stackoverflow.com/questions/42755590/how-to-display-only-bottom-border-for-selected-item-in-uisegmentedcontrol
extension UISegmentedControl{
    
    func removeBorder(){
        let backgroundImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: self.bounds.size)
        self.setBackgroundImage(backgroundImage, for: .normal, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .selected, barMetrics: .default)
        self.setBackgroundImage(backgroundImage, for: .highlighted, barMetrics: .default)
        
        let deviderImage = UIImage.getColoredRectImageWith(color: UIColor.white.cgColor, andSize: CGSize(width: 1.0, height: self.bounds.size.height))
        self.setDividerImage(deviderImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.gray], for: .normal)
        self.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor(red: 67/255, green: 129/255, blue: 244/255, alpha: 1.0)], for: .selected)
    }
    
    func addUnderlineForSelectedSegment(){
        removeBorder()
        let underlineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments)
        let underlineHeight: CGFloat = 2.0
        let underlineXPosition = CGFloat(selectedSegmentIndex * Int(underlineWidth))
        let underLineYPosition = self.bounds.size.height - 1.0
        let underlineFrame = CGRect(x: underlineXPosition, y: underLineYPosition, width: underlineWidth, height: underlineHeight)
        let underline = UIView(frame: underlineFrame)
        underline.backgroundColor = UIColor(red: 67/255, green: 129/255, blue: 244/255, alpha: 1.0)
        underline.tag = 1
        self.addSubview(underline)
    }
    
    func changeUnderlinePosition(){
        guard let underline = self.viewWithTag(1) else {return}
        let underlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex)
        UIView.animate(withDuration: 0.1, animations: {
            underline.frame.origin.x = underlineFinalXPosition
        })
    }
}

extension UIImage{
    
    class func getColoredRectImageWith(color: CGColor, andSize size: CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let graphicsContext = UIGraphicsGetCurrentContext()
        graphicsContext?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        graphicsContext?.fill(rectangle)
        let rectangleImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return rectangleImage!
    }
}
