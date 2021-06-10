// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let userPhoto = try? newJSONDecoder().decode(UserPhoto.self, from: jsonData)

import Foundation

// MARK: - UserPhoto
struct StructUserPhoto: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let albumID: Int
    let reposts: Reposts
    let postID: Int?
    let id, date: Int
    let text: Text
    let sizes: [PhotoUrl]
    let hasTags: Bool
    let ownerID: Int
    let likes: Likes
    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case reposts
        case postID = "post_id"
        case id, date, text, sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
        case likes
    }
}

// MARK: - Likes
struct Likes: Codable {
    let userLikes, count: Int

    enum CodingKeys: String, CodingKey {
        case userLikes = "user_likes"
        case count
    }
}

// MARK: - Reposts
struct Reposts: Codable {
    let count: Int
}

// MARK: - Size
struct PhotoUrl: Codable {
    //let width, height: Int
    let url: String
    //let type: String
}

enum Text: String, Codable {
    case empty = ""
    case безКомментариев = "без комментариев )))"
}
