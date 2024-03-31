//
//  UserListViewModelTests.swift
//  UserListTests
//
//  Created by Yannick LEPLARD on 29/03/2024.
//

import XCTest
@testable import UserList

final class UserListViewModelTests: XCTestCase {
    
    var userListVM: UserListViewModel = UserListViewModel(repository: UserListRepository())
        
//    override func setUp() {
//            super.setUp()
//        }
//
//    override func tearDown() {
//        super.tearDown()
//    }
    
    func testVar()
    {
        //XCTAssert(userListVM.users.count != 0)
    }
    
    func testFetchUsers()
    {
    
    }
    
    func testReloadsUsers()
    {
    
    }
    
}
