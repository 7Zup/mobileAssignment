//
//  Message.swift
//  mobileAssignment
//
//  Created by Fabrice Froehly on 28/12/2017.
//  Copyright © 2017 Fabrice Froehly. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

class MessageList: Mappable {
    
    var messages: [Message]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        messages    <- map["messages"]
    }
}





class Message: Mappable {
    
    var message: String?
    var user: User?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        message <- map["message"]
        user    <- map["user"]
    }
}
