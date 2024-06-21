//
//  CommentsViewModel.swift
//  InstagramTutorial
//
//  Created by Jeremy Koo on 2/26/24.
//

import Firebase

@MainActor
class CommentsViewModel: ObservableObject {
    @Published var comments = [Comment]()
    
    private let post: Post
    private let service: CommentService
    
    init(post: Post) {
        self.post = post
        self.service = CommentService(postId: post.id)
        
        Task { try await fetchComments() }
    }
    
    func uploadComment(commentText: String) async throws {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let comment = Comment(
            commentOwnerUid: uid,
            commentText: commentText,
            postId: post.id,
            postOwnerUid: post.ownerUid,
            timestamp: Timestamp()
        )
        
//        self.comments.insert(comment, at: 0)
//        self.comments[0].user = UserService.shared.currentUser
        
        try await service.uploadComment(comment)
        try await fetchComments()
        
        NotificationManager.shared.uploadCommentNotification(toUid: post.ownerUid, post: post)
    }
    
    func fetchComments() async throws {
        self.comments = try await service.fetchComment()
        try await fetchUserDataForComments()
    }
    
    private func fetchUserDataForComments() async throws {
        for i in 0 ..< comments.count {
            let comment = comments[i]
            let user = try await UserService.fetchUser(withUid: comment.commentOwnerUid)
            comments[i].user = user
        }
    }
}
