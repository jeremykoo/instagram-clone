//
//  Comment.swift
//  InstagramTutorial
//
//  Created by Jeremy Koo on 2/26/24.
//

import Firebase
import FirebaseFirestoreSwift

struct Comment: Identifiable, Codable {
    @DocumentID var commentId: String?
    
    let commentOwnerUid: String
    let commentText: String
    let postId: String
    let postOwnerUid: String
    let timestamp: Timestamp
    
    var user: User?
    
    var id: String {
        return commentId ?? UUID().uuidString
    }
}
