//
//  CustomTableViewCell.swift
//  AC-iOS-Final
//
//  Created by Richard Crichlow on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

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
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        return activityIndicator
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
        postImageView.layer.masksToBounds = true
        setupAndConstrainObjects()
    }
    
    public func configureCell(withPost post: Post) {
        self.commentTextView.text = "\(post.comment)"
        
        getImages(withPost: post)
    }
    
    private func getImages(withPost post: Post) {
        self.postImageView.image = nil
        
        guard post.imageURL != nil else {
            print("No image url")
            return
        }
        // If the image is already cached
        ImageCache(name: post.imageURL!).retrieveImage(forKey: post.imageURL!, options: nil, completionHandler: { (image, _) in
            if let image = image {
                self.postImageView.image = image
                self.layoutIfNeeded()
            } else {
                // If the image is not in cache
                guard let imageUrlString = post.imageURL, let url = URL(string: imageUrlString) else {
                    self.postImageView.image = #imageLiteral(resourceName: "NoDataAvailable")
                    self.layoutIfNeeded()
                    return
                }
                self.postImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "NoDataAvailable"), options: nil, progressBlock: nil, completionHandler: { (image, error, _, _) in
                    if let image = image {
                        ImageCache(name: post.imageURL!).store(image, forKey: post.imageURL!)
                    }
                    if let error = error {
                        print(error)
                    }
                    self.layoutIfNeeded()
                })
            }
        })
    }
    
    private func setupAndConstrainObjects(){
        
        self.addSubview(postImageView)
        self.addSubview(commentTextView)
        self.addSubview(activityIndicator)
        
        postImageView.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(self.snp.width).multipliedBy(0.09).priority(999)
            make.top.equalTo(self.snp.top).offset(5)
            make.leading.equalTo(self.snp.leading).offset(5)
        }
        activityIndicator.snp.makeConstraints { (make) in
            make.edges.equalTo(postImageView)
        }
        commentTextView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postImageView.snp.bottom).offset(5)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            make.bottom.equalTo(self.snp.bottom).offset(5)
            make.height.equalTo(postImageView.snp.height).multipliedBy(0.5)
        }
        
    }
}
