//
//  CreatePublicChannelTests.swift
//  mobileAssignmentTests
//
//  Created by Fabrice Froehly on 26/12/2017.
//  Copyright © 2017 Fabrice Froehly. All rights reserved.
//

@testable import mobileAssignment
import XCTest
import UIKit

/// Test the public channel creation/deletion
class ChannelTests: XCTestCase {
    
    // Variables
    var nickname: String = "Fabylou"
    var user: User!
    var channelName = "Test Channel"
    var channel: Channel!
    
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
    // MARK: - Create and close channel
    
    /// Test that creates a channel
    func test_a_openClosePublicChannel() {
        
        // create channel
        APIController.shared.openChannel(channelName: self.channelName, completionHandler: openChannelCompletionHandler)
        
        // Wait for asynchronous functions to finish
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertNotNil(self.channel)
        XCTAssertEqual(self.channelName, self.channel.name)
        
        self.exp = expectation(description: "\(#function)\(#line)")
        
        if let channel_url = self.channel.channel_url {
            
            // close channel
            APIController.shared.deleteChannel(channel_url: channel_url, completionHandler: deleteChannelCompletionHandler)
        }
        
        // Wait for asynchronous functions to finish
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    /// Completion called when the create channel had succeeded
    ///
    /// - Parameter channel: The channel returned
    func openChannelCompletionHandler(channel: Channel?) {
        
        // If channel has been create
        if let channel = channel {
            
            self.channel = channel
        } else {
            
            XCTFail()
        }
        // Ends waiting
        self.exp.fulfill()
    }
    
    /// Completion called when the get user had succeeded
    ///
    /// - Parameter user: The user returned
    func deleteChannelCompletionHandler(channel: Channel?) {
        
        // Get user to see if its really deleted
        XCTAssertNil(channel?.channel_url)
        self.exp.fulfill()
    }
}
