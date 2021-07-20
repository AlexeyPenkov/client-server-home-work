//
//  SearchResponse.swift
//  lesson1
//
//  Created by Алексей Пеньков on 27.05.2021.
//

import Foundation

struct HeadResponseUsers: Codable {
    let response: SearchResponseUsers
}

struct SearchResponseUsers: Codable {
    let count: Int
    let items: [UserInfo]
}

struct UserInfo: Codable {
    let first_name: String
    let last_name: String
    let id: Int
    let photo: String?

//    enum CodingKeys: String, CodingKey {
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case photo = "photo_200_orig"
//    }

}


