//
//  SearchResponseCommunity.swift
//  lesson1
//
//  Created by Алексей Пеньков on 28.05.2021.
//

import Foundation

struct HeadResponseCommunity: Decodable {
    var response: SearchResponseCommunity
}

struct SearchResponseCommunity: Decodable {
    var count: Int
    var items: [CommunityInfo]
}

struct CommunityInfo: Decodable {
    var name: String
    var id: Int
    var photo: String?
}
