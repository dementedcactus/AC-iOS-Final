//
//  DatabaseService+Add.swift
//  AC-iOS-Final
//
//  Created by Richard Crichlow on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseAuth

extension DatabaseService {
    
    /**
     Stores a UserProfile object in the database after account creation.
     
     - Parameter userProfile: The UserProfile object passed in.
     */
    public func addUserProfile(_ userProfile: UserProfile) {
        //find the node that you want to be doing stuff to
        let ref = usersRef.child(userProfile.userID)
        
        //Database.database().reference().child("cards").child(userProfile.userID).childByAutoId()
        
        
        //now that you have the node, call the setValue function (which has a completion handler) to input values that you want to set to that node
        //think of the node as a being part of a dictionary
        //the node is the key, and you are assigning its value; which is another dictionary in this case
        //ref : [key: value]
        ref.setValue(["email": userProfile.email,
                      "userID": userProfile.userID,
                      "displayName": userProfile.displayName
            
        ]) { (error, _) in
            if let error = error {
                self.delegate?.didFailAddingUserProfile?(self, error: error.localizedDescription)
                print("\(userProfile) not added to firebase")
            } else {
                print("new user added to database!!")
            }
        }
    }
    /*
    public func addCard(_ card: Card) {
        //1. find ref
        let ref = cardsRef.child(card.cardUID)
        
        //2. call set value with completion handler
        ref.setValue(["question": card.question,
                      "answer": card.answer,
                      "category": card.category,
                      "gotRight": card.gotRight ?? false,
                      "userID": card.userID,
                      "cardUID": card.cardUID]) { (error, nil) in
                        if let error = error {
                            print(error)
                        } else {
                            print("Card Added")
                            self.refreshDelegate?.refreshTableView()
                            self.showAlertDelegate?.showAlertDelegate(cardOrDeck: "Card")
                        }
        }
    }
    
    public func addDeck(_ deck: Deck) {
        //1. find ref
        let ref = decksRef.child(deck.userID).child(deck.name)
        
        //2. call set value with completion handler
        ref.setValue(["name": deck.name,
                      "numberOfCards": deck.numberOfCards ?? 0,
                      "userID": deck.userID]) { (error, nil) in
                        if let error = error {
                            print(error)
                        } else {
                            print("Deck Added")
                            self.refreshDelegate?.refreshTableView()
                            self.showAlertDelegate?.showAlertDelegate(cardOrDeck: "Deck")
                        }
        }
    }
    */
}
