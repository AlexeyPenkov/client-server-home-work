//
//  PhotosRealm.swift
//  lesson1
//
//  Created by Алексей Пеньков on 02.06.2021.
//

import Foundation
import RealmSwift

class PhotosRealm: Object {
    
    @objc dynamic var userId: Int = 0
    @objc dynamic var photo: String = ""
    
}
