//
//  CurrentUserTableViewCell.swift
//  
//
//  Created by C4Q on 1/30/18.
//

import UIKit
import SnapKit

//1
protocol CurrentUserProfileTableViewCellDelegate: class {
    func didEditUserName(_ tableViewCell: CurrentUserTableViewCell)
    func didEditProfileImage(_ tableViewCell:  CurrentUserTableViewCell)
}

//MARK: called "Current User Cell"
class CurrentUserTableViewCell: UITableViewCell {
    
    var indexPath = IndexPath()
    
    //2: initializing delegate: this is where you want to call the delegate
    weak var delegate: CurrentUserProfileTableViewCellDelegate?
    
    lazy var profileBackGroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = convertImageToBW(image: #imageLiteral(resourceName: "warMachine"))
        imageView.contentMode = .scaleAspectFill
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = imageView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0.75
        imageView.addSubview(blurEffectView)
        return imageView
    }()
    
    //User name label
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "warMachines"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .white
        return label
    }()
    
    
    //Name TextField
    lazy var userNameTextField: UITextField = {
        let tf = UITextField()
        tf.isHidden = true
        tf.textColor = UIColor.white
        tf.font = UIFont.boldSystemFont(ofSize: 17)
        return tf
    }()
    
    
    //Name Edit Button
    lazy var userNameEditButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "editPencil"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.backgroundColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(editUserNameButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    //Edit Image Button
    lazy var imageEditButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "editPencil"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.backgroundColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(editImageButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    lazy var profileImage: UIImageView = {
        let imageView = roundedImageView()
        imageView.layer.borderWidth = 2
        imageView.clipsToBounds = true
        imageView.image = #imageLiteral(resourceName: "warMachine")
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //////////////// Custom delegate actions
    
    @objc func editUserNameButtonPressed() {
        //3: call delegate
        self.delegate?.didEditUserName(self)
    }
    
    @objc func editImageButtonPressed(_ sender: UIButton){
        //3: call delegate
        self.delegate?.didEditProfileImage(self)
    }
    
    ////////////////  Initializtion
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "profileImageCell")
        setupViews()
        self.userNameTextField.delegate = self
    }
    
    //get the actual frmae size of the elements before getting laid out on screen
    override func layoutSubviews() {
        super.layoutSubviews()
        //make profile image a circle
        imageEditButton.layer.cornerRadius = imageEditButton.bounds.height / 2.0
        imageEditButton.layer.masksToBounds = true
        userNameEditButton.layer.cornerRadius = userNameEditButton.bounds.height / 2.0
        userNameEditButton.layer.masksToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    ////////////////  Constraints
    
    private func setupViews(){
        setupProfileBackGroundView()
        setupProfileImageView()
        setupUserNameLabel()
        setupUserNameTextField()
        setupUserNameEditButton()
        setupImageEditButton()
    }
    
    private func setupProfileBackGroundView(){
        addSubview(profileBackGroundView)
        profileBackGroundView.snp.makeConstraints { (constraint) in
            constraint.edges.equalTo(snp.edges)
        }
    }
    
    private func setupProfileImageView(){
        addSubview(profileImage)
        profileImage.snp.makeConstraints { (constraint) in
            constraint.center.equalTo(snp.center)
            constraint.width.equalTo(snp.width).multipliedBy(0.45)
            constraint.height.equalTo(snp.width).multipliedBy(0.45)
        }
    }
    
    private func setupUserNameLabel(){
        addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(profileImage.snp.bottom).offset(5)
            constraint.centerX.equalTo(snp.centerX)
        }
    }
    
    private func convertImageToBW(image:UIImage) -> UIImage {
        let filter = CIFilter(name: "CIPhotoEffectMono")
        // convert UIImage to CIImage and set as input
        let ciInput = CIImage(image: image)
        filter?.setValue(ciInput, forKey: "inputImage")
        // get output CIImage, render as CGImage first to retain proper UIImage scale
        let ciOutput = filter?.outputImage
        let ciContext = CIContext()
        let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)
        return UIImage(cgImage: cgImage!)
    }
    
    //userNameEditTextField
    private func setupUserNameTextField(){ //exact as userName Label
        addSubview(userNameTextField)
        userNameTextField.snp.makeConstraints { (constraint) in
            constraint.top.equalTo(profileImage.snp.bottom).offset(5)
            constraint.centerX.equalTo(snp.centerX)
            constraint.width.equalTo(userNameLabel.snp.width)
        }
    }
    
    //userNameEditButton
    private func setupUserNameEditButton(){ //exact as userName Label
        addSubview(userNameEditButton)
        userNameEditButton.snp.makeConstraints{ (constraint) in
            constraint.top.equalTo(profileImage.snp.bottom).offset(30)
            //constraint.leading.equalTo(userNameLabel.snp.trailing).offset(5)
            constraint.width.equalTo(snp.width).multipliedBy(0.07)
            constraint.height.equalTo(snp.width).multipliedBy(0.07)
            constraint.centerX.equalTo(snp.centerX)
        }
    }
    
    //imageEditButton
    private func setupImageEditButton() {
        addSubview(imageEditButton)
        imageEditButton.snp.makeConstraints{(constraint) in
            constraint.centerX.equalTo(snp.centerX).offset(65)
            constraint.center.equalTo(snp.center).offset(70)
            constraint.width.equalTo(snp.width).multipliedBy(0.08)
            constraint.height.equalTo(snp.width).multipliedBy(0.08)
        }
    }
}

//MARK: TextField Delegate
extension CurrentUserTableViewCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.userNameLabel.text = textField.text!
        print(textField.text!)
        self.userNameLabel.isHidden = false
        self.userNameTextField.isHidden = true
        textField.resignFirstResponder()
        return true
    }
}
