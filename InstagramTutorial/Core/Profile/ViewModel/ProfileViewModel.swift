//
//  ProfileViewModel.swift
//  InstagramTutorial
//
//  Created by Jeremy Koo on 2/27/24.
//

import Foundation

@MainActor
class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        print("DEBUG: Did init..")
        self.user = user
        checkIfUserIsFollowed()
        fetchUserStats()
    }
    
    func fetchUserStats() {
        // dont need this guard but just in case
        guard user.stats == nil else { return }
        Task {
            self.user.stats = try await UserService.fetchUserStats(uid: user.id)
        }
    }
}

// MARK: - Following

extension ProfileViewModel {
    func follow() {
        Task {
            try await UserService.follow(uid: user.id)
            user.isFollowed = true
            
            NotificationManager.shared.uploadFollowNotification(toUid: user.id)
        }
    }
    
    func unfollow() {
        Task {
            try await UserService.unfollow(uid: user.id)
            user.isFollowed = false
            
            await NotificationManager.shared.deleteFollowNotification(notificationOwnerUid: user.id)
        }
    }
    
    func checkIfUserIsFollowed() {
        // dont need this guard but just in case
        guard user.isFollowed == nil else { return }
        Task {
            self.user.isFollowed = try await UserService.checkIfUserIsFollowed(uid: user.id)
        }
    }
}
