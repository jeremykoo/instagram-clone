//
//  CommentService.swift
//  InstagramTutorial
//
//  Created by Jeremy Koo on 2/26/24.
//

import FirebaseFirestoreSwift
import Firebase

struct CommentService {
    
    let postId: String
    
    func uploadComment(_ comment: Comment) async throws {
        guard let commentData = try? Firestore.Encoder().encode(comment) else { return }
        
        try await FirebaseConstants
            .PostsCollection
            .document(postId)
            .collection("post-comments")
            .addDocument(data: commentData)
    }
    
    func fetchComment() async throws -> [Comment] {
        let snapshot = try await FirebaseConstants
            .PostsCollection
            .document(postId)
            .collection("post-comments")
            .order(by: "timestamp", descending: true)
            .getDocuments()
        
        return snapshot.documents.compactMap({ try? $0.data(as: Comment.self) })
    }
}
