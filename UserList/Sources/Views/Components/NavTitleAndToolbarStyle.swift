//
//  NavTitleAndToolbarStyle.swift
//  UserList
//
//  Created by Yannick LEPLARD on 02/04/2024.
//

import SwiftUI



struct NavTitleToolbarStyle: ViewModifier {
    var viewModel: UserListViewModel

    func body(content: Content) -> some View {
        content.navigationTitle("Users")
            .toolbar {
                ItemsToolbar(viewModel: viewModel)
            }
    }
}

extension View {
    func navTitleToolbarStyle(_ viewModel: UserListViewModel) -> some View {
        modifier(NavTitleToolbarStyle(viewModel: viewModel))
    }
}
