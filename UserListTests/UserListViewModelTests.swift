//
//  UserListViewModelTests.swift
//  UserListTests
//
//  Created by Yannick LEPLARD on 29/03/2024.
//

import XCTest
//import Combine
@testable import UserList

final class UserListViewModelTests: XCTestCase {
    
    //var cancellables: Set<AnyCancellable> = []
    
    private var userListVM: UserListViewModel? // = UserListViewModel(repository: UserListRepository(executeDataRequest: UserListRepository.mockExecuteDataRequest))
        
    @MainActor
    override func setUp() {
        userListVM = UserListViewModel(repository: UserListRepository(executeDataRequest: UserListRepository.mockExecuteDataRequest))
            super.setUp()
        }
    
    override func tearDown() {
        userListVM = nil
        super.tearDown()
    }
    
    @MainActor
    func testFetchUsers() async throws {
        let NB_ITERATIONS = 3
    
        XCTAssert(userListVM!.users.isEmpty)

        for _ in 1...NB_ITERATIONS {
            try await userListVM!.fetchUsers()
        }
        
        XCTAssertEqual(userListVM!.users.count, UserListRepository.USERS_QUANTITY_TEST * NB_ITERATIONS)
    }
    
    @MainActor
    func testShouldLoadMoreData() async throws {
        XCTAssert(userListVM!.users.isEmpty)
        
        try await userListVM!.fetchUsers()
        
        XCTAssertEqual(userListVM!.users.count, UserListRepository.USERS_QUANTITY_TEST)

        var ret = userListVM!.shouldLoadMoreData(currentItem: userListVM!.users.first! )
        XCTAssertEqual(ret, false)
        
        ret = userListVM!.shouldLoadMoreData(currentItem: userListVM!.users.last!)
        XCTAssertEqual(ret, true)
        
    }
    
    @MainActor
    func testReloadsUsers() async throws {
        XCTAssert(userListVM!.users.isEmpty)
                
        try await userListVM!.fetchUsers()
        XCTAssertEqual(userListVM!.users.count, UserListRepository.USERS_QUANTITY_TEST)
        userListVM!.users.removeFirst()
        XCTAssertEqual(userListVM!.users.count, UserListRepository.USERS_QUANTITY_TEST - 1)
        
        try await userListVM!.reloadUsers()
        
        XCTAssertEqual(userListVM!.users.count, UserListRepository.USERS_QUANTITY_TEST)
    }
    
}
