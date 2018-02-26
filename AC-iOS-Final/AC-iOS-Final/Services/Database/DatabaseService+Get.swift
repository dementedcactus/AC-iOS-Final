//
//  DatabaseService+Get.swift
//  AC-iOS-Final
//
//  Created by Richard Crichlow on 2/26/18.
//  Copyright © 2018 C4Q . All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DatabaseService {
    
    /** Generates a UserProfile object for the current user from the database.
     
     - Parameters:
     - uid: The unique userID for the current, authenticated user.
     - completion: A closure that executes after a UserProfile is made.
     - userProfile: A UserProfile object for the current user.
     */
    public func getUserProfile(withUID uid: String, completion: @escaping (_ userProfile: UserProfile) -> Void) {
        let ref = usersRef.child(uid)
        ref.observe(.value) { (dataSnapshot) in
            guard let email = dataSnapshot.childSnapshot(forPath: "email").value as? String else {
                return
            }
            guard let displayName = dataSnapshot.childSnapshot(forPath: "displayName").value as? String else {
                return
            }
            
            let currentUserProfile = UserProfile(email: email, userID: uid, displayName: displayName)
            completion(currentUserProfile)
        }
    }
    
    /*
    func getAllDecks(fromUserID userID: String, completion: @escaping ([Deck]?) -> Void) {
        let deckRef = decksRef.child(userID)
        deckRef.observeSingleEvent(of: .value) { (dataSnapshot) in
            //print(dataSnapshot)
            guard let arrayOfDeckSnapshot = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                print("could not get children snapshots")
                completion(nil)
                return
            }
            var deckArrayToRetur: [Deck] = [] // This is the empty deck that will be filled by the completion handler
            for deckSnapshot in arrayOfDeckSnapshot {
                guard let deckDictionary = deckSnapshot.value as? [String : Any] else {
                    print("could not get deck dict")
                    completion(nil)
                    return
                }
                guard let downcastedUserID = deckDictionary["userID"] as? String else {
                    completion(nil)
                    return
                }
                guard let downcastedName = deckDictionary["name"] as? String else {
                    completion(nil)
                    return
                }
                guard let downcastedNumberOfCards = deckDictionary["numberOfCards"] as? Int else {
                    completion(nil)
                    return
                }
                let deck = Deck(userID: downcastedUserID,
                                name: downcastedName,
                                numberOfCards: downcastedNumberOfCards)
                deckArrayToRetur.append(deck)
            }
            completion(deckArrayToRetur)
        }
    }
    
    func getAllFlashcardsByCategory(forUserID userID: String, andDeck deck: String, completion: @escaping ([Card]?) -> Void) {
        
        cardsRef.observeSingleEvent(of: .value) { (dataSnapshot) in
            guard let flashcardsSnapshot = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                print("could not get children snapshots")
                completion(nil)
                return
            }
            var flashcards: [Card] = [] // This is what gets returned in the completion handler
            for flashcardSnapshot in flashcardsSnapshot {
                guard let flashcardDict = flashcardSnapshot.value as? [String : Any] else {
                    print("could not get flashcard dict")
                    completion(nil)
                    return
                }
                guard let downcastedQuestion = flashcardDict["question"] as? String else {
                    completion(nil)
                    return
                }
                guard let downcastedAnswer = flashcardDict["answer"] as? String else {
                    completion(nil)
                    return
                }
                guard let downcastedCategory = flashcardDict["category"] as? String else {
                    completion(nil)
                    return
                }
                guard let downcastedGotRight = flashcardDict["gotRight"] as? Bool else {
                    completion(nil)
                    return
                }
                guard let downcastedUserID = flashcardDict["userID"] as? String else {
                    completion(nil)
                    return
                }
                guard let downcastedCardID = flashcardDict["cardUID"] as? String else {
                    completion(nil)
                    return
                }
                let flashcard = Card(question: downcastedQuestion,
                                     answer: downcastedAnswer,
                                     category: downcastedCategory,
                                     gotRight: downcastedGotRight,
                                     userID: downcastedUserID,
                                     cardUID: downcastedCardID)
                if flashcard.category != deck {
                    continue
                }
                flashcards.append(flashcard)
            }
            //completion(flashcards.sortedByTimestamp())
            completion(flashcards)
        }
    }
    
    func getAllFlashcards(forUserID userID: String, completion: @escaping ([Card]?) -> Void) {
        
        cardsRef.observeSingleEvent(of: .value) { (dataSnapshot) in
            guard let flashcardsSnapshot = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                print("could not get children snapshots")
                completion(nil)
                return
            }
            var flashcards: [Card] = [] // This is what gets returned in the completion handler
            for flashcardSnapshot in flashcardsSnapshot {
                guard let flashcardDict = flashcardSnapshot.value as? [String : Any] else {
                    print("could not get flashcard dict")
                    completion(nil)
                    return
                }
                guard let downcastedQuestion = flashcardDict["question"] as? String else {
                    completion(nil)
                    return
                }
                guard let downcastedAnswer = flashcardDict["answer"] as? String else {
                    completion(nil)
                    return
                }
                guard let downcastedCategory = flashcardDict["category"] as? String else {
                    completion(nil)
                    return
                }
                guard let downcastedGotRight = flashcardDict["gotRight"] as? Bool else {
                    completion(nil)
                    return
                }
                guard let downcastedUserID = flashcardDict["userID"] as? String else {
                    completion(nil)
                    return
                }
                guard let downcastedCardID = flashcardDict["cardUID"] as? String else {
                    completion(nil)
                    return
                }
                let flashcard = Card(question: downcastedQuestion,
                                     answer: downcastedAnswer,
                                     category: downcastedCategory,
                                     gotRight: downcastedGotRight,
                                     userID: downcastedUserID,
                                     cardUID: downcastedCardID)
                
                flashcards.append(flashcard)
            }
            completion(flashcards)
        }
    }
 */
    
    
}
