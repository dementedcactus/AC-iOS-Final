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
    
    // MARK: DataSource
    var decksArray = [Post]() {
        didSet {
            mainFeedView.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        //TBV Delegates
        mainFeedView.tableView.delegate = self
        mainFeedView.tableView.dataSource = self
        mainFeedView.tableView.estimatedRowHeight = 150
        mainFeedView.tableView.rowHeight = UITableViewAutomaticDimension
        DatabaseService.manager.refreshDelegate = self
    }
    
    private func setupView() {
        view.addSubview(mainFeedView)
    }
    
    @objc func logOutButtonAction() {
        AuthUserService.manager.signOut()
        self.navigationController?.popToRootViewController(animated: true)
    }
}

extension MainFeedVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return decksArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! CustomTableViewCell
        
        let aPost = decksArray[indexPath.row]
        
        //cell.deckLabel.text = " \(aPost.name)"
        //cell.numberOfCardsInDeckLabel.text = ""
        
        return cell
    }
    
    
}

extension MainFeedVC: RefreshDelegate {
    func refreshTableView() {
//        DatabaseService.manager.getAllDecks(fromUserID: (AuthUserService.manager.getCurrentUser()?.uid)!, completion: { (someData) in
//            if let deckArray = someData {
//                self.decksArray = deckArray
//                
//            } else {
//                print("Couldn't get decks or there are no decks")
//                //TODO: Maybe show an image of no data as a background
//            }
//        })
    }
}
