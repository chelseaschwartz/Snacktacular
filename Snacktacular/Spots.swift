//
//  Spots.swift
//  Snacktacular
//
//  Created by Chelsea Schwartz on 4/5/21.
//

import Foundation
import Firebase

class Spots {
    var spotArray: [Spot] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ()) {
        db.collection("spots").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("ERROR: ADDING THE SNAPSHOT LISTENER \(error!.localizedDescription)")
                return completed()
            }
            self.spotArray = []
            for document in querySnapshot!.documents {
                let spot = Spot(dictionary: document.data())
                spot.documentID = document.documentID
                self.spotArray.append(spot)
            }
            completed()
        }
    }
}
