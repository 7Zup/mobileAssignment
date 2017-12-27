//
//  LoginTests.swift
//  mobileAssignmentTests
//
//  Created by Fabrice Froehly on 26/12/2017.
//  Copyright © 2017 Fabrice Froehly. All rights reserved.
//

import XCTest
import Foundation
import UIKit
@testable import mobileAssignment

/// Test the basic functions of the user
class UserTests: XCTestCase {
    
    var nickname: String = "Fabylou"
    var profile_url: String = "https://picsum.photos/50/50/?image=5"
    var user: User?
    
    // Timer
    var exp: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        
        // Enable the waiting part
        self.exp = expectation(description: "\(#function)\(#line)")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    
    
    
    /*****************************************************************************/
    // MARK: - Login functions
    
    /// Test login/create
    func test_a_Login() {
        
        // get/create user
        APIController.shared.getUser(nickname: self.nickname, completionHandler: getUserCompletionHandler)
        
        // Wait for asynchronous functions to finish
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(self.nickname, self.user?.nickname)
    }
    
    /// Completion called when the get user had succeeded
    ///
    /// - Parameter user: The user returned
    func getUserCompletionHandler(user: User?) {
        
        if let user = user {
            
            self.user = user
            exp.fulfill()
        } else {
            
            APIController.shared.createUser(nickname: self.nickname, completionHandler: createUserCompletionHandler)
        }
    }
    
    /// Completion called when the get user had succeeded
    ///
    /// - Parameter user: The user returned
    func createUserCompletionHandler(user: User?) {
        
        if let user = user {
            
            self.user = user
        } else {
            
            XCTFail("Failure: Could get nor create user")
        }
        self.exp.fulfill()
    }

    /// Test user profile modification
    ///
    /// - Parameter user: the user to update
    func test_b_ProfileModification() {
        
        // Get the user for profile modification
        APIController.shared.getUser(nickname: self.nickname, completionHandler: getUserCompletionHandler)
        waitForExpectations(timeout: 10, handler: nil)
        // When user is filled
        
        // Modification of a tmpUser to avoid modify the real user without doing the API call
        let userTmp = self.user!.copy() as! User
        userTmp.profile_url = self.profile_url
        
        // Reset expectation
        self.exp = expectation(description: "\(#function)\(#line)")
        
        // API call to modify image
        APIController.shared.putUser(user: userTmp, completionHandler: modifyUserCompletionHandler)
        
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(self.profile_url, self.user?.profile_url)
    }
    
    /// Completion called when the put user had succeeded
    ///
    /// - Parameter user: The user returned
    func modifyUserCompletionHandler(user: User?) {
        
        if let user = user {
            
            self.user = user
        } else {
            
            XCTFail("Failure: User is nil")
        }
        self.exp.fulfill()
    }
    
    // Edit profile_url
    // Delete user

    
    
    
    
    
    /*****************************************************************************/
    // MARK: - Delete functions
    
    /// Test delete
    func test_c_Delete() {
        
        APIController.shared.deleteUser(nickname: self.nickname, completionHandler: deleteUserCompletionHandler)
        
        // Wait after API call
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Completion called when the get user had succeeded
    ///
    /// - Parameter user: The user returned
    func getUserTestDeletionCompletionHandler(user: User?) {
        
        // If deleted, user is nil
        XCTAssertNil(user)
        self.exp.fulfill()
    }
    
    /// Completion called when the get user had succeeded
    ///
    /// - Parameter user: The user returned
    func deleteUserCompletionHandler(user: User?) {

        // Get user to see if its really deleted
        APIController.shared.getUser(nickname: self.nickname, completionHandler: getUserTestDeletionCompletionHandler)
    }
}
