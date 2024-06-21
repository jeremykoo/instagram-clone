//
//  UserStatView.swift
//  InstagramTutorial
//
//  Created by Jeremy Koo on 2/20/24.
//

import SwiftUI

struct UserStatView: View {
    let value: Int
    let title: String
    
    var body: some View {
        VStack {
            Text("\(value)")
                .font(.subheadline)
                .fontWeight(.semibold)
            Text(title)
                .font(.footnote)
        }
        .opacity(value == 0 ? 0.5 : 1.0)
        .frame(width: 72)    }
}

#Preview {
    UserStatView(value: 12, title: "Posts")
}
