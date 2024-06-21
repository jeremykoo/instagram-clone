//
//  NotificationManager.swift
//  InstagramTutorial
//
//  Created by Jeremy Koo on 2/29/24.
//

import Foundation

class NotificationManager {
    
    static let shared = NotificationManager()
    private let service = NotificationService()
    
    private init() { }
    
    func uploadLikeNotification(toUid uid: String, post: Post) {
        service.uploadNotifications(toUid: uid, type: .like, post: post)
    }
    
    func uploadCommentNotification(toUid uid: String, post: Post) {
        service.uploadNotifications(toUid: uid, type: .comment, post: post)
    }
    
    func uploadFollowNotification(toUid uid: String) {
        service.uploadNotifications(toUid: uid, type: .follow)
    }
    
    func deleteLikeNotification(notificationOwnerUid: String, post: Post) async {
        do {
            try await service.deleteNotification(toUid: notificationOwnerUid, type: .like, post: post)
        } catch {
            print("DEBUG: Failed to delete like notification")
        }
    }
    
    func deleteFollowNotification(notificationOwnerUid: String) async {
        do {
            try await service.deleteNotification(toUid: notificationOwnerUid, type: .follow)
        } catch {
            print("DEBUG: Failed to delete follow notification")
        }
    }
}
