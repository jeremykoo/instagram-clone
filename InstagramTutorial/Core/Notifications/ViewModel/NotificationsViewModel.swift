//
//  NotificationsViewModel.swift
//  InstagramTutorial
//
//  Created by Jeremy Koo on 2/29/24.
//

import Foundation

@MainActor
class NotificationsViewModel: ObservableObject {
    @Published var notifications = [Notification]()
    
    private let service: NotificationService
    private var currentUser: User?
    
    init(service: NotificationService) {
        self.service = service
        
        Task { await fetchNotifications() }
        
        self.currentUser = UserService.shared.currentUser
    }
    
    func fetchNotifications() async {
        do {
            self.notifications = try await service.fetchNotifications()
            try await updateNotifications()
        } catch {
            print("DEBUG: Failed to fetch notifications with error \(error.localizedDescription)")
        }
    }
    
    // slow and can be improved to load all notifications at the same time rather than one at a time
    private func updateNotifications() async throws {
        for i in 0 ..< notifications.count {
            var notification = notifications[i]
            
            notification.user = try await UserService.fetchUser(withUid: notification.notificationSenderUid)
            
            if let postId = notification.postId {
                notification.post = try await PostService.fetchPost(postId)
                notification.post?.user = self.currentUser
            }
            
            notifications[i] = notification
        }
    }
}


// MARK: - Following

//extension NotificationsViewModel {
//    func follow() {
//        Task {
//            try await UserService.follow(uid: user.id)
//            user.isFollowed = true
//            
//            NotificationManager.shared.uploadFollowNotification(toUid: user.id)
//        }
//    }
//    
//    func unfollow() {
//        Task {
//            try await UserService.unfollow(uid: user.id)
//            user.isFollowed = false
//            
//            await NotificationManager.shared.deleteFollowNotification(notificationOwnerUid: user.id)
//        }
//    }
//    
//    func checkIfUserIsFollowed() {
//        // dont need this guard but just in case
//        guard user.isFollowed == nil else { return }
//        Task {
//            self.user.isFollowed = try await UserService.checkIfUserIsFollowed(uid: user.id)
//        }
//    }
//}

