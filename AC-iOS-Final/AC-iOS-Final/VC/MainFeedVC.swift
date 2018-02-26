//
//  MainFeedVC.swift
//  AC-iOS-Final
//
//  Created by Richard Crichlow on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import UIKit

class MainFeedVC: UIViewController {

    let mainFeedView = MainFeedView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView
    }

    private func setupView() {
    view.addSubview(mainFeedView)
    }
    
}
