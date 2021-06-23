// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let newsHeadResponse = try? newJSONDecoder().decode(NewsHeadResponse.self, from: jsonData)

import Foundation

// MARK: - NewsHeadResponse
struct NewsHeadResponse: Codable {
    let response: ResponseNews
}

// MARK: - Response
struct ResponseNews: Codable {
    let items: [ItemNews]
}

// MARK: - Item
struct ItemNews: Codable {
    let attachments: [Attachment]
    let text: String
    
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: String
    let photo: Photo
}

// MARK: - Photo
struct Photo: Codable {
    let sizes: [Size]
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
    let url: String
    let type: String
}
