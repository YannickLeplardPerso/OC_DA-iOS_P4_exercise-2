//
//  UserNavLink.swift
//  UserList
//
//  Created by Yannick LEPLARD on 29/03/2024.
//

import SwiftUI

struct UserNavLink: View {
    @ObservedObject var viewModel: UserListViewModel
    let user: User
    let uiElements: () -> some View 
    var body: some View {
        NavigationLink(destination: UserDetailView(user: user)) {
            uiElements()
        }
        .onAppear {
            if viewModel.shouldLoadMoreData(currentItem: user) {
                viewModel.fetchUsers()
            }
        }
    }
}

//#Preview {
//    UserNavLink()
//}
