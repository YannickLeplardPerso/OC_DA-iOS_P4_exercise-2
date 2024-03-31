//
//  ToolbarItems.swift
//  UserList
//
//  Created by Yannick LEPLARD on 29/03/2024.
//

import SwiftUI

struct ItemsToolbar: ToolbarContent {
    @ObservedObject var viewModel: UserListViewModel

    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Picker(selection: $viewModel.isGridView, label: Text("Display")) {
                Image(systemName: "rectangle.grid.1x2.fill")
                    .tag(true)
                    .accessibilityLabel(Text("Grid view"))
                Image(systemName: "list.bullet")
                    .tag(false)
                    .accessibilityLabel(Text("List view"))
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                viewModel.reloadUsers()
            }) {
                Image(systemName: "arrow.clockwise")
                    .imageScale(.large)
            }
        }
    }
}
