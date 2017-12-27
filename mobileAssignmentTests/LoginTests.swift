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

/// Test the basic login/logout functions of the application
class LoginTests: XCTestCase {
    
    var nickname: String = "Fabylou"
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
    func testLogin() {
        
        APIController.shared.getUser(nickname: self.nickname, completionHandler: getUserCompletionHandler)
        
        // Wait for asynchronous functions to finish
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(self.nickname, self.user?.nickname)
    }
    
    /// Completion called when the get user had succeeded
    ///
    /// - Parameter user: The user returned
    func getUserCompletionHandler(user: User?) {
        
        if let user = user {
            
            self.user = user
            self.exp.fulfill()
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

    
    
    
    
    
    /*****************************************************************************/
    // MARK: - Delete functions
    
    /// Test delete
    func testDelete() {
        
        APIController.shared.deleteUser(nickname: self.nickname, completionHandler: deleteUserCompletionHandler)
        
        // Wait after API call
        waitForExpectations(timeout: 5, handler: nil)
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
