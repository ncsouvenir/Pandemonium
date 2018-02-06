//
//  CurrentUserTableViewCell.swift
//  
//
//  Created by C4Q on 1/30/18.
//

import UIKit
import SnapKit


////MARK: called "Current User Cell"
//class CurrentUserTableViewCell: UserCommentTableViewCell {
//
//    lazy var profileBackGroundView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = convertImageToBW(image: #imageLiteral(resourceName: "warMachine"))
//        imageView.contentMode = .scaleAspectFill
//        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = imageView.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        blurEffectView.alpha = 0.75
//        imageView.addSubview(blurEffectView)
//        return imageView
//    }()
//
//    lazy var userNameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "warMachines"
//        label.font = UIFont.boldSystemFont(ofSize: 15)
//        label.textColor = .white
//        return label
//    }()
//
//
//
//
//    /////////////////////////////////
//    //Nicole's added UIelements and constraints
//
//    //Name TextField
//    lazy var userNameTextField: UITextField = {
//        let tf = UITextField()
//        return tf
//    }()
//
//
//    //Name Edit Button
//    lazy var userNameEditButton: UIButton = {
//        let button = UIButton()
//        button.setImage(#imageLiteral(resourceName: "editPencil"), for: .normal)
//        return button
//    }()
//
//
//    //Edit Image Button
//    lazy var imageEditButton: UIButton = {
//        let button = UIButton()
//        button.setImage(#imageLiteral(resourceName: "editPencil"), for: .normal)
//        return button
//    }()
//    /////////////////////////////////
//
//
//
//
//    lazy var profileImage: UIImageView = {
//        let imageView = roundedImageView()
//        imageView.layer.borderWidth = 2
//        imageView.clipsToBounds = true
//        imageView.image = #imageLiteral(resourceName: "warMachine")
//        imageView.layer.borderColor = UIColor.white.cgColor
//        imageView.contentMode = .scaleAspectFill
//        return imageView
//    }()
//
//
//
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: "profileImageCell")
//        setupViews()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//
//    private func setupViews(){
//        setupProfileBackGroundView()
//        setupProfileImageView()
//        setupUserNameLabel()
//        setupUserNameEditTextField()
//        setupUserNameEditButton()
//        setupImageEditButton()
//    }
//
//    private func setupProfileBackGroundView(){
//        addSubview(profileBackGroundView)
//        profileBackGroundView.snp.makeConstraints { (constraint) in
//            constraint.edges.equalTo(snp.edges)
//        }
//    }
//    private func setupProfileImageView(){
//        addSubview(profileImage)
//        profileImage.snp.makeConstraints { (constraint) in
//            constraint.center.equalTo(snp.center)
//            constraint.width.equalTo(snp.width).multipliedBy(0.45)
//            constraint.height.equalTo(snp.width).multipliedBy(0.45)
//        }
//    }
//    private func setupUserNameLabel(){
//        addSubview(userNameLabel)
//        userNameLabel.snp.makeConstraints { (constraint) in
//            constraint.top.equalTo(profileImage.snp.bottom).offset(5)
//            constraint.centerX.equalTo(snp.centerX)
//        }
//    }
//    private func convertImageToBW(image:UIImage) -> UIImage {
//        let filter = CIFilter(name: "CIPhotoEffectMono")
//        // convert UIImage to CIImage and set as input
//        let ciInput = CIImage(image: image)
//        filter?.setValue(ciInput, forKey: "inputImage")
//        // get output CIImage, render as CGImage first to retain proper UIImage scale
//        let ciOutput = filter?.outputImage
//        let ciContext = CIContext()
//        let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)
//        return UIImage(cgImage: cgImage!)
//    }
//
//    //userNameEditTextField
//    private func setupUserNameTextField(){ //exact as userName Label
//        addSubview(userNameTextField)
//        userNameTextField.snp.makeConstraints { (constraint) in
//            constraint.top.equalTo(profileImage.snp.bottom).offset(5)
//            constraint.centerX.equalTo(snp.centerX)
//        }
//    }
//
//    //userNameEditButton
//    private func setupUserNameEditButton(){ //exact as userName Label
//        addSubview(userNameEditButton)
//        userNameEditButton.snp.makeConstraints{ (constraint) in
//            constraint.top.equalTo(profileImage.snp.bottom).offset(5)
//            //constrain just to the left of the textfield
//            constraint.trailing.equalTo(userNameLabel.snp.trailing).offset(10)
//            constraint.centerX.eqaulTo(snp.centerX)
//        }
//    }
//
//    //imageEditButton
//    private func setupImageEditButton() {
//        addSubview(imageEditButton)
//        imageEditButton.snp.makeConstraints{(constraint) in
//            constraint.center.equalTo(snp.center)
//            constraint.width.equalTo(snp.width).multipliedBy(0.45)
//            constraint.height.equalTo(snp.width).multipliedBy(0.45)
//            constraint.trailing.equalTo(profileImage.snp.trailing).offset(10)
//        }
//    }
//}

