//
//  FBUsersList.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 17.06.2021.
//

import Foundation
import Firebase

class FBGroups {
    let name: String
    let groupid: Int
    let ref: DatabaseReference?
    
    init(name: String, groupid: Int) {
        self.name = name
        self.groupid = groupid
        self.ref = nil
    }
    
    init?(snapshot: DataSnapshot) {
        guard
            let value = snapshot.value as? [String: Any],
            let name = value["name"] as? String,
            let groupid = value["groupid"] as? Int else {
            return nil
        }
        self.ref = snapshot.ref
        self.name = name
        self.groupid = groupid
    }
    
    func toDictionary() -> [String: Any] {
        return ["name": name,
                "groupid": groupid]
    }
}
