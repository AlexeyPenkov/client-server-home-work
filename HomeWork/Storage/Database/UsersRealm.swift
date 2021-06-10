//
//  UsersRealm.swift
//  lesson1
//
//  Created by Алексей Пеньков on 02.06.2021.
//

import Foundation
import RealmSwift

class UserRealm: Object {
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var id: Int = 0
//    @objc dynamic var photo: UIImage?
    @objc dynamic var photo: String = ""
}
