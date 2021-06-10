//
//  SearchResponse.swift
//  lesson1
//
//  Created by Алексей Пеньков on 27.05.2021.
//

import Foundation

struct HeadResponseUsers: Decodable {
    var response: SearchResponseUsers
}

struct SearchResponseUsers: Decodable {
    var count: Int
    var items: [UserInfo]
}

struct UserInfo: Decodable {
    var firstName: String
    var lastName: String
    var id: Int
    var photo: String?
}
