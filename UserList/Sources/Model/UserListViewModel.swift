//
//  UserListViewModel.swift
//  UserList
//
//  Created by Yannick LEPLARD on 25/03/2024.
//

//import Foundation

import SwiftUI

@MainActor
final class UserListViewModel: ObservableObject {
    // MARK: - Private properties
    
    static let USERS_QUANTITY_TO_FETCH: Int = 20
    
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
    
    func fetchUsers() async throws {
        isLoading = true
            let users = try await repository.fetchUsers(quantity: UserListViewModel.USERS_QUANTITY_TO_FETCH)
            self.users.append(contentsOf: users)
            isLoading = false
    }
     
    func reloadUsers() async throws {
        users.removeAll()
        try await fetchUsers()
    }



}
