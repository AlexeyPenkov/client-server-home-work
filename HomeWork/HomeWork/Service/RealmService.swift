//
//  FuncForWorkingWithRealm.swift
//  lesson1
//
//  Created by Алексей Пеньков on 03.06.2021.
//

import Foundation
import RealmSwift

class RealmService: NSObject {
    
    //MARK: - function to write and read Users from Realm
    
    func writeUserInfoToRealm(userArray: [UserInfo]) {
        
        var tempArray = [UserRealm]()
        
        for item in userArray {
            let userRealm = UserRealm()
            
            
            userRealm.firstName = item.first_name
            userRealm.lastName = item.last_name 
            userRealm.id = item.id
            userRealm.photo = item.photo!
            
            tempArray.append(userRealm)
            
        }
        let realm = try! Realm()

        try? realm.write {
            realm.add(tempArray)
       }
       
       
    }
    
    
    //MARK: - function to write and read Groups from Realm
    
    func writeGroupsInfoFromRealm(groupArray: [CommunityInfo]) {
        var tempArray = [GroupRealm]()
        
        for item in groupArray {
            let groupRealm = GroupRealm()
            
            groupRealm.id = item.id
            groupRealm.name = item.name
            groupRealm.photo = item.photo_100 ?? ""
            
            tempArray.append(groupRealm)
        }
        
        let realm = try! Realm()
        try? realm.write {
            realm.add(tempArray)
        }
    }
    
    
    //MARK: - function to write and read OtherGropus from Realm
    
    func writeOtherGroupsInfoFromRealm(otherGroupArray: [CommunityInfo]) {
        var tempArray = [OtherGroupRealm]()
        
        for item in otherGroupArray {
            let groupRealm = OtherGroupRealm()
            
            groupRealm.id = item.id
            groupRealm.name = item.name
            groupRealm.photo = item.photo_100 ?? ""
            
            tempArray.append(groupRealm)
        }
        
        let realm = try! Realm()
        try? realm.write {
            realm.add(tempArray)
        }
    }
    
    //MARK: - function to write and read Photo from Realm
    
    func writePhotosFromRealm(userId: Int, photoArray: [String]) {
        var tempArray = [PhotosRealm]()
        
        for item in photoArray {
            let groupRealm = PhotosRealm()
            
            groupRealm.userId = userId
                
            groupRealm.photo = item
            
            tempArray.append(groupRealm)
        }
        
        let realm = try! Realm()
        try? realm.write {
            realm.add(tempArray)
        }
    }
    
    func readPhotosFromRealm() -> [PhotosRealm] {
        var groupArray = [PhotosRealm]()
        do {
            let realm = try Realm()
            let usersRealm = realm.objects(PhotosRealm.self)
            
            for item in usersRealm {
                groupArray.append(item)
            }
            
        } catch  {
            print(error)
        }
        return groupArray
    }
    
    func clearUsersRealm() {
        let realm = try! Realm()
        try? realm.write {
            realm.deleteAll()
        }
    }
}
