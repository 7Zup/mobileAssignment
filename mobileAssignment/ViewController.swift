//
//  ViewController.swift
//  mobileAssignment
//
//  Created by Fabrice Froehly on 24/12/2017.
//  Copyright © 2017 Fabrice Froehly. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var nickname: String = "Fabylou"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        APIController.shared.getUser(nickname: self.nickname, completionHandler: getUserCompletionHandler)
    }

    /// Completion called when the get user had succeeded
    ///
    /// - Parameter user: The user returned
    func getUserCompletionHandler(user: User?) {
        
        if let user = user {
            
            print("SUCCESS: user nickname is: \(user.nickname ?? "Nickname not found")")
        } else {
            
            print("FAILURE: Couldn't get user")
            APIController.shared.createUser(nickname: self.nickname, completionHandler: createUserCompletionHandler)
        }
    }
    
    /// Completion called when the get user had succeeded
    ///
    /// - Parameter user: The user returned
    func createUserCompletionHandler(user: User?) {
        
        if let user = user {
            
            print("SUCCESS: user nickname is: \(user.nickname ?? "Nickname not found")")
        } else {
            
            print("FAILURE: Couldn't create user")
        }
    }
}

