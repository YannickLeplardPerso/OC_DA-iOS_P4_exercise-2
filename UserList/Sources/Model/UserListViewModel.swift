//
//  UserListViewModel.swift
//  UserList
//
//  Created by Yannick LEPLARD on 25/03/2024.
//

//import Foundation

import SwiftUI

final class UserListViewModel: ObservableObject {
    // MARK: - Private properties
    
    private let repository: UserListRepository
    private var isLoading = false
    
    // MARK: - Init
    
    init(repository: UserListRepository) {
        self.repository = repository
    }

    // MARK: - Outputs
    
    @Published var users: [User] = []
    @Published var isGridView = false
    
    func shouldLoadMoreData(currentItem item: User) -> Bool {
        guard let lastItem = users.last else { return false }
        return !isLoading && item.id == lastItem.id
    }

    // MARK: - Inputs
        //.receive(on: RunLoop.main)
    
    func fetchUsers() {
        isLoading = true
        Task { @MainActor in
            do {
                let users = try await repository.fetchUsers(quantity: 20)
                self.users.append(contentsOf: users)
                isLoading = false
            } catch {
                print("Error fetching users: \(error.localizedDescription)")
            }
        }
    }
     
    func reloadUsers() {
        users.removeAll()
        fetchUsers()
    }



}
