//
//  User.swift
//  lesson1
//
//  Created by Алексей Пеньков on 11.04.2021.
//

import Foundation
import UIKit

struct User {
    
    var name: String?
    //var age: String
    var avatar: UIImage?
    var photoArray = [Photo]()
    
    var firstName: String {
        didSet {
            name = firstName + " " + lastName
        }
    }
    var lastName: String {
        didSet {
            name = firstName + " " + lastName
        }
    }
    var id: Int
    var photo: String?
}