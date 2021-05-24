//
//  DataStorage.swift
//  lesson1
//
//  Created by Алексей Пеньков on 11.04.2021.
//

import UIKit

class DataStorage: NSObject {
    static let share = DataStorage()
    private override init() {
        super.init()
    }
    var usersArray = [User]()
    var groupsArray = [Group]()
    var otherGroupsArray = [Group]()
    var newsArr = [NewsStruct]()
    
}
