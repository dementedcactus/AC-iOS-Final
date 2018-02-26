//
//  Post.swift
//  AC-iOS-Final
//
//  Created by Richard Crichlow on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation

class Post: Codable {
    
    var postID: String
    var imageURL: String?
    var comment: String
    
    init(postID: String, imageURL: String, comment: String) {
        self.postID = postID
        self.imageURL = imageURL
        self.comment = comment
        
    }
}
