// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let newsResponse = try? newJSONDecoder().decode(NewsResponse.self, from: jsonData)

import Foundation

// MARK: - NewsResponse
struct NewsHeadResponse: Codable {
    let response: NewsResponse
}

// MARK: - Response
struct NewsResponse: Codable {
    let items: [ItemsNews]
}

// MARK: - Item
struct ItemsNews: Codable {
    var text: String
    var attachments: [Attachment]?
}

// MARK: - Attachment
struct Attachment: Codable {
    let photo: Photo?
}

struct Photo: Codable {
    let sizes: [PhotoUrl]
}









