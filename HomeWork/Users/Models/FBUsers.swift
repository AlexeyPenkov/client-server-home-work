//
//  FBUsersList.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 17.06.2021.
//

import Foundation
import Firebase

class FBUsers {
    let id: Int
    let ref: DatabaseReference?
    
    init(id: Int) {
        self.id = id
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let id = value["id"] as? Int else {
            return nil
        }
        self.ref = snapshot.ref
        self.id = id
    }
    
    func toDictionary() -> [String: Any] {
        return ["id": id]
    }
}
