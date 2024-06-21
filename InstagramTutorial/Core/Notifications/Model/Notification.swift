//
//  Notification.swift
//  InstagramTutorial
//
//  Created by Jeremy Koo on 2/29/24.
//

import Firebase

struct Notification: Identifiable, Codable {
    let id: String
    var postId: String?
    let timestamp: Timestamp
    let notificationSenderUid: String
    let type: NotificationType
    
    var post: Post?
    var user: User?
}
