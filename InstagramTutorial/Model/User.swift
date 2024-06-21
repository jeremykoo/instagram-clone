//
//  User.swift
//  InstagramTutorial
//
//  Created by Jeremy Koo on 2/21/24.
//

import Foundation
import Firebase

struct User: Identifiable, Hashable, Codable {
    let id: String
    var username: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String
    
    var isFollowed: Bool? = false
    var stats: UserStats?
    
    var isCurrentUser: Bool {
        guard let currentUid = Auth.auth().currentUser?.uid else { return false }
        return currentUid == id
    }
}

struct UserStats: Codable, Hashable {
    var followingCount: Int
    var followersCount: Int
    var postsCount: Int
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: UUID().uuidString, username: "batman", profileImageUrl: nil, fullname: "Bruce Wayne", bio: "Gotham's Dark Knight", email: "batman@gmail.com"),
        .init(id: UUID().uuidString, username: "venom", profileImageUrl: nil, fullname: "Eddie Brock", bio: "Venom", email: "venom@gmail.com"),
        .init(id: UUID().uuidString, username: "ironman", profileImageUrl: nil, fullname: "Tony Stark", bio: "Billionaire", email: "ironman@gmail.com"),
        .init(id: UUID().uuidString, username: "blackpanther", profileImageUrl: nil, fullname: nil, bio: "Wakanda Forever", email: "blackpanther@gmail.com"),
        .init(id: UUID().uuidString, username: "spiderman", profileImageUrl: nil, fullname: "Peter Parker", bio: "Friendly Neighborhood Spiderman", email: "spiderman@gmail.com"),
    ]
}
