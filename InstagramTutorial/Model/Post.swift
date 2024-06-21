//
//  Post.swift
//  InstagramTutorial
//
//  Created by Jeremy Koo on 2/21/24.
//

import Foundation
import Firebase

struct Post: Identifiable, Hashable, Codable {
    let id: String
    let ownerUid: String
    let caption: String
    var likes: Int
    let imageUrl: String
    let timestamp: Timestamp
    var user: User?
    
    var didLike: Bool? = false
}

extension Post {
    static let MOCK_IMAGE_URL = "https://firebasestorage.googleapis.com:443/v0/b/instagramswiftui-22394.appspot.com/o/profile_images%2FB70FA869-C342-4756-BDC0-C2D1B948F89C?alt=media&token=7a1a94b3-4d15-41d7-9400-1210fa46c681"
    
    static var MOCK_POSTS: [Post] = [
        .init(
            id: UUID().uuidString,
            ownerUid: UUID().uuidString,
            caption: "This is some test caption for now.",
            likes: 123,
            imageUrl: "batman",
            timestamp: Timestamp(),
            user: User.MOCK_USERS[0]
        ),
        .init(
            id: UUID().uuidString,
            ownerUid: UUID().uuidString,
            caption: "venom venom venom",
            likes: 92,
            imageUrl: "venom",
            timestamp: Timestamp(),
            user: User.MOCK_USERS[1]
        ),
        .init(
            id: UUID().uuidString,
            ownerUid: UUID().uuidString,
            caption: "ironman ironman ironman",
            likes: 532,
            imageUrl: "ironman",
            timestamp: Timestamp(),
            user: User.MOCK_USERS[2]
        ),
        .init(
            id: UUID().uuidString,
            ownerUid: UUID().uuidString,
            caption: "black panther black panther",
            likes: 12,
            imageUrl: "blackpanther",
            timestamp: Timestamp(),
            user: User.MOCK_USERS[3]
        ),
        .init(
            id: UUID().uuidString,
            ownerUid: UUID().uuidString,
            caption: "spidey spidey spideyman",
            likes: 158,
            imageUrl: "spiderman",
            timestamp: Timestamp(),
            user: User.MOCK_USERS[4]
        ),
        .init(
            id: UUID().uuidString,
            ownerUid: UUID().uuidString,
            caption: "spidey spidey spideyman",
            likes: 201,
            imageUrl: "black-panther-2",
            timestamp: Timestamp(),
            user: User.MOCK_USERS[4]
        ),
    ]
}
