//
//  SearchResponseUserPhotos.swift
//  lesson1
//
//  Created by Алексей Пеньков on 28.05.2021.
//

import Foundation

struct HeadResponseUserPhotos: Decodable {
    var response: SearchResponseUserPhotos
}

struct SearchResponseUserPhotos: Decodable {
    var count: Int
    var items: [UserPhoto]
}

struct UserPhoto: Decodable {
    var id: Int
    var sizes: [Photo]
}

struct Photo: Decodable {
    var url: String?
}
