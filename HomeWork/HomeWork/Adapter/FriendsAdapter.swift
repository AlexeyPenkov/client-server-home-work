//
//  FriendsAdapter.swift
//  HomeWork
//
//  Created by Алексей Пеньков on 17.08.2021.
//

import Foundation
import RealmSwift

class FriendsAdapter {
//    private let realmService = RealmService()
    private var realmNotificationToken: [String: NotificationToken] = [:]
    
    func getFriends(complition: @escaping ([Friends]) -> Void) {
        do {
            let realm = try Realm()
            let usersRealm = realm.objects(UserRealm.self)
            
        } catch  {
            print(error)
        }
        
        
        
        
    }
}
