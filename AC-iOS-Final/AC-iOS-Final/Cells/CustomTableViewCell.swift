//
//  CustomTableViewCell.swift
//  AC-iOS-Final
//
//  Created by Richard Crichlow on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {

    //userImageView - for user image
    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        Stylesheet.Objects.ImageViews.Opaque.style(imageView: imageView)
        imageView.layer.borderWidth = CGFloat(Stylesheet.BorderWidths.FunctionButtons)
        return imageView
    }()
    
    //categoryLabel - for Post Category
    lazy var commentTextView: UITextView = {
        let ctv = UITextView()
        Stylesheet.Objects.Textviews.Completed.style(textview: ctv)
        return ctv
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: "PostCell")
        setupAndConstrainObjects()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAndConstrainObjects()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .white
        contentView.layer.borderColor = Stylesheet.Colors.LightGrey.cgColor
        contentView.layer.borderWidth = 3
        setupAndConstrainObjects()
    }
    
    public func configureCell(withPost post: Post) {
        self.categoryLabel.text = "This is \(post.category)"
        self.postTitleLabel.text = post.title
        self.numberOfLikesLabel.text = "+" +  post.numberOfLikes.description
        self.numberOfDislikesLabel.text = "-" +  post.numberOfDislikes.description
        
        if let postText = post.bodyText, !postText.isEmpty {
            self.postTextView.text = postText
        } else {
            self.postTextView.text = nil
        }
        
        getImages(withPost: post)
    }
    
    private func getImages(withPost post: Post) {
        self.userImageView.image = nil
        DatabaseService.manager.getUserProfile(withUID: post.userID) { (userProfile) in
            self.usernameLabel.text = userProfile.displayName
            
            ImageCache(name: post.userID).retrieveImage(forKey: post.userID, options: nil, completionHandler: { (image, _) in
                if let image = image {
                    self.userImageView.image = image
                    self.layoutIfNeeded()
                } else {
                    guard let userUrlString = userProfile.imageURL, let url = URL(string: userUrlString) else {
                        self.userImageView.image = #imageLiteral(resourceName: "placeholder-image")
                        self.layoutIfNeeded()
                        return
                    }
                    self.userImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder-image"), options: nil, progressBlock: nil, completionHandler: { (image, error, _, _) in
                        if let image = image {
                            ImageCache(name: post.userID).store(image, forKey: post.userID)
                        }
                        if let error = error {
                            print(error)
                        }
                        self.layoutIfNeeded()
                    })
                }
            })
        }
        
        self.postImageView.image = nil
        //self.activityIndicator.startAnimating()
        if let postURLString = post.imageURL, let imageURL = URL(string: postURLString) {
            ImageCache(name: post.postID).retrieveImage(forKey: post.postID, options: nil, completionHandler: { (image, _) in
                if let image = image {
                    self.postImageView.image = image
                    self.activityIndicator.stopAnimating()
                    self.layoutIfNeeded()
                } else {
                    self.postImageView.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "placeholder-image"), options: nil, progressBlock: nil, completionHandler: { (image, error, _, _) in
                        if let image = image {
                            ImageCache(name: post.postID).store(image, forKey: post.postID)
                            self.activityIndicator.stopAnimating()
                            self.layoutIfNeeded()
                        }
                    })
                }
            })
        } else {
            self.postImageView.image = #imageLiteral(resourceName: "meatly_logo")
            //self.activityIndicator.stopAnimating()
            self.layoutIfNeeded()
        }
    }
    
    private func setupAndConstrainObjects(){
        
        self.addSubview(postImageView)
        self.addSubview(commentTextView)
        
        postImageView.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(self.snp.width).multipliedBy(0.09).priority(999)
            make.top.equalTo(self.snp.top).offset(5)
            make.leading.equalTo(self.snp.leading).offset(5)
        }
        commentTextView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postImageView.snp.bottom).offset(5)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            make.bottom.equalTo(self.snp.bottom).offset(5)
            make.height.equalTo(postImageView.snp.height).multipliedBy(0.5)
        }
        usernameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(categoryLabel.snp.bottom)
            make.leading.equalTo(userImageView.snp.trailing).offset(5)
            make.height.equalTo(userImageView.snp.height).multipliedBy(0.5)
        }
        postTitleLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self.snp.leading).offset(5)
            make.top.equalTo(usernameLabel.snp.bottom).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
        }
        postTextView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postImageView.snp.bottom).offset(5)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
        }
        postImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postTitleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(self.snp.centerX).priority(999)
            make.bottom.equalTo(postTextView.snp.top).offset(-5)
            make.height.equalTo(self.snp.width)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
        }
        activityIndicator.snp.makeConstraints { (make) in
            make.edges.equalTo(postImageView)
        }
        showThreadButton.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(commentButton.snp.centerY)
            make.leading.equalTo(commentButton.snp.trailing).offset(2)
        }
        thumbsUpButton.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(showThreadButton.snp.centerY)
            make.leading.equalTo(self.snp.leading).offset(5)
        }
        numberOfLikesLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(thumbsUpButton.snp.trailing).offset(2).priority(999)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.height.equalTo(self.snp.width).multipliedBy(0.07)
        }
        thumbsDownButton.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(numberOfLikesLabel.snp.trailing).offset(2)
            make.centerY.equalTo(showThreadButton.snp.centerY)
        }
        numberOfDislikesLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(thumbsDownButton.snp.trailing).offset(2).priority(998)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.height.equalTo(self.snp.width).multipliedBy(0.07)
        }
        commentButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.centerX.equalTo(self.snp.centerX)
        }
        flagButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            
        }
        showArrowButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postTextView.snp.bottom).offset(5).priority(999)
            make.trailing.equalTo(shareButton.snp.leading).offset(-2)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            
        }
        shareButton.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            make.centerY.equalTo(commentButton.snp.centerY)
        }
    }
}
