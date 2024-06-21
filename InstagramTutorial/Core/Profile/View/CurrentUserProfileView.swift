//
//  CurrentUserProfileView.swift
//  InstagramTutorial
//
//  Created by Jeremy Koo on 2/21/24.
//

import SwiftUI

struct CurrentUserProfileView: View {
    
    let user: User
    
//    var posts: [Post] {
//        return Post.MOCK_POSTS.filter( { $0.user?.username == user.username } )
//    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                // header
                ProfileHeaderView(user: user)
                
                // post grid view
                PostGridView(user: user)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        AuthService.shared.signout()
                    } label: {
                        Image(systemName: "line.3.horizontal")
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    CurrentUserProfileView(user: User.MOCK_USERS[0])
}
