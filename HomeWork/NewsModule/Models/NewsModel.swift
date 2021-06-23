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
    let items: [ItemsNews]
    let groups: [Group]
    let profiles: [Profile]
    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case items, groups, profiles
        case nextFrom = "next_from"
    }
}

// MARK: - Group
struct Group: Codable {
    let isMember, id: Int
    let photo100: String
    let isAdvertiser, isAdmin: Int
    let photo50, photo200: String
    let type, screenName, name: String
    let isClosed: Int

    enum CodingKeys: String, CodingKey {
        case isMember = "is_member"
        case id
        case photo100 = "photo_100"
        case isAdvertiser = "is_advertiser"
        case isAdmin = "is_admin"
        case photo50 = "photo_50"
        case photo200 = "photo_200"
        case type
        case screenName = "screen_name"
        case name
        case isClosed = "is_closed"
    }
}

// MARK: - Item
struct ItemsNews: Codable {
    let canDoubtCategory: Bool
    let postID: Int
    let likes: Likes
    let isFavorite: Bool
    let views: Views
    let signerID: Int
    let canSetCategory: Bool
    let sourceID: Int
    let type: String
    let date: Int
    let shortTextRate: Double
    let attachments: [Attachment]
    let postSource: PostSource
    let postType: String
    let markedAsAds: Int
    let text: String
    let comments: Comments
    let reposts: Reposts
    let donut: Donut
    let copyright: Copyright

    enum CodingKeys: String, CodingKey {
        case canDoubtCategory = "can_doubt_category"
        case postID = "post_id"
        case likes
        case isFavorite = "is_favorite"
        case views
        case signerID = "signer_id"
        case canSetCategory = "can_set_category"
        case sourceID = "source_id"
        case type, date
        case shortTextRate = "short_text_rate"
        case attachments
        case postSource = "post_source"
        case postType = "post_type"
        case markedAsAds = "marked_as_ads"
        case text, comments, reposts, donut, copyright
    }
}

// MARK: - Attachment
struct Attachment: Codable {
    let type: String
    let photo: Photo
}

// MARK: - Photo
struct Photo: Codable {
    let albumID, postID, id, date: Int
    let text: String
    let userID: Int
    let sizes: [Size]
    let hasTags: Bool
    let ownerID: Int
    let accessKey: String

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case postID = "post_id"
        case id, date, text
        case userID = "user_id"
        case sizes
        case hasTags = "has_tags"
        case ownerID = "owner_id"
        case accessKey = "access_key"
    }
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int
    let url: String
    let type: String
}

// MARK: - Comments
struct Comments: Codable {
    let count, canPost: Int
    let groupsCanPost: Bool

    enum CodingKeys: String, CodingKey {
        case count
        case canPost = "can_post"
        case groupsCanPost = "groups_can_post"
    }
}

// MARK: - Copyright
struct Copyright: Codable {
    let id: Int
    let type, name: String
    let link: String
}

// MARK: - Donut
struct Donut: Codable {
    let isDonut: Bool

    enum CodingKeys: String, CodingKey {
        case isDonut = "is_donut"
    }
}

// MARK: - Likes
struct Likes: Codable {
    let canLike, canPublish, count, userLikes: Int

    enum CodingKeys: String, CodingKey {
        case canLike = "can_like"
        case canPublish = "can_publish"
        case count
        case userLikes = "user_likes"
    }
}

// MARK: - PostSource
struct PostSource: Codable {
    let type: String
}

// MARK: - Reposts
struct Reposts: Codable {
    let count, userReposted: Int

    enum CodingKeys: String, CodingKey {
        case count
        case userReposted = "user_reposted"
    }
}

// MARK: - Views
struct Views: Codable {
    let count: Int
}

// MARK: - Profile
struct Profile: Codable {
    let canAccessClosed: Bool
    let screenName: String
    let online, id: Int
    let photo100: String
    let lastName: String
    let photo50: String
    let onlineInfo: OnlineInfo
    let sex: Int
    let isClosed: Bool
    let firstName: String

    enum CodingKeys: String, CodingKey {
        case canAccessClosed = "can_access_closed"
        case screenName = "screen_name"
        case online, id
        case photo100 = "photo_100"
        case lastName = "last_name"
        case photo50 = "photo_50"
        case onlineInfo = "online_info"
        case sex
        case isClosed = "is_closed"
        case firstName = "first_name"
    }
}

// MARK: - OnlineInfo
struct OnlineInfo: Codable {
    let visible, isMobile, isOnline: Bool
    let appID, lastSeen: Int?

    enum CodingKeys: String, CodingKey {
        case visible
        case isMobile = "is_mobile"
        case isOnline = "is_online"
        case appID = "app_id"
        case lastSeen = "last_seen"
    }
}
