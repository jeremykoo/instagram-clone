//
//  NotificationsCell.swift
//  InstagramTutorial
//
//  Created by Jeremy Koo on 2/29/24.
//

import SwiftUI
import Kingfisher

struct NotificationCell: View {
    let notification: Notification
    @State private var isFollowed = false
    
    private var buttonBackgroundColor: Color {
        if isFollowed {
            return .white
        } else {
            return Color(.systemBlue)
        }
    }
    
    private var buttonForegroundColor: Color {
        if isFollowed {
            return .black
        } else {
            return .white
        }
    }
    
    private var buttonBorderColor: Color {
        if isFollowed {
            return .gray
        } else {
            return .clear
        }
    }
    
    var body: some View {
        HStack {
            
            NavigationLink(value: notification.user) {
                CircularProfileImageView(user: notification.user, size: .xSmall)
            }
            
            // notification message
            HStack {
                Text(notification.user?.username ?? "")
                    .font(.subheadline)
                    .fontWeight(.semibold) +
                
                Text(" \(notification.type.notificationMessage)")
                    .font(.subheadline) +
                
                Text(" \(notification.timestamp.timestampString())")
                    .foregroundStyle(.gray)
                    .font(.footnote)
            }
            
            Spacer()
            
            if notification.type != .follow {
                NavigationLink(value: notification.post) {
                    KFImage(URL(string: notification.post?.imageUrl ?? ""))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipped()
                        .padding(.leading, 2)
                }
            } else {
                Button {
//                    print("DEBUG: Handle follow here..")
                    checkIfUserIsFollowed()
                    if isFollowed {
                        unfollow()
                    } else {
                        follow()
                    }
                } label: {
                    Text(isFollowed ? "Following" : "Follow")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .frame(width: 88, height: 32)
                        .foregroundStyle(buttonForegroundColor)
                        .background(buttonBackgroundColor)
                        .clipShape(RoundedRectangle(cornerRadius: 6))
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(buttonBorderColor, lineWidth: 1)
                        )
                }
            }
        }
        .task {
            checkIfUserIsFollowed()
        }
        .padding(.horizontal)
    }
    
    private func follow() {
        Task {
            guard let user = notification.user else { return }
            try await UserService.follow(uid: user.id)
            NotificationManager.shared.uploadFollowNotification(toUid: user.id)
        }
    }
    
    private func unfollow() {
        Task {
            guard let user = notification.user else { return }
            try await UserService.unfollow(uid: user.id)
            await NotificationManager.shared.deleteFollowNotification(notificationOwnerUid: user.id)
        }
    }
    
    private func checkIfUserIsFollowed() {
        Task {
            guard let user = notification.user else { return }
            self.isFollowed = try await UserService.checkIfUserIsFollowed(uid: user.id)
        }
    }
}

#Preview {
    NotificationCell(notification: DeveloperPreview.shared.notifications[0])
}
