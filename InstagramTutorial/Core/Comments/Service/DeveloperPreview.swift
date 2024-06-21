//
//  DeveloperPreview.swift
//  InstagramTutorial
//
//  Created by Jeremy Koo on 2/27/24.
//

import SwiftUI
import Firebase

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    let comment = Comment(commentOwnerUid: "123", commentText: "Test comment for now", postId: "3214", postOwnerUid: "1231203", timestamp: Timestamp())
    
    let notifications: [Notification] = [
        .init(id: UUID().uuidString, timestamp: Timestamp(), notificationSenderUid: "123", type: .like),
        .init(id: UUID().uuidString, timestamp: Timestamp(), notificationSenderUid: "456", type: .comment),
        .init(id: UUID().uuidString, timestamp: Timestamp(), notificationSenderUid: "789", type: .follow),
        .init(id: UUID().uuidString, timestamp: Timestamp(), notificationSenderUid: "124", type: .like),
        .init(id: UUID().uuidString, timestamp: Timestamp(), notificationSenderUid: "125", type: .like),
    ]
}
