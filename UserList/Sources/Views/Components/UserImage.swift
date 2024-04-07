//
//  UserImage.swift
//  UserList
//
//  Created by Yannick LEPLARD on 29/03/2024.
//

import SwiftUI

struct UserImage: View {
    let user: User
    let frameSize: CGFloat
    
    var body: some View {
        AsyncImage(url: URL(string: user.picture.thumbnail)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: frameSize, height: frameSize)
                .clipShape(Circle())
        } placeholder: {
            ProgressView()
                .frame(width: frameSize, height: frameSize)
                .clipShape(Circle())
        }
    }
}
