//
//  GroupRealm.swift
//  lesson1
//
//  Created by Алексей Пеньков on 02.06.2021.
//

import Foundation
import RealmSwift

class GroupRealm: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var photo: String = ""
}
