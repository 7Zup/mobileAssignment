//
//  Channel.swift
//  mobileAssignment
//
//  Created by Fabrice Froehly on 26/12/2017.
//  Copyright © 2017 Fabrice Froehly. All rights reserved.
//

import UIKit
import ObjectMapper

class ChannelList: Mappable {
    
    var channels: [Channel]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        channels         <- map["channels"]
    }
}

class Channel: Mappable {
    
    var channel_url: String?
    var name: String?
    var cover_url: String?
    var operators: [User]?
    var participants: [User]?
    var max_length_message: Int?
    var freeze: Bool?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        
        channel_url         <- map["channel_url"]
        name                <- map["name"]
        cover_url           <- map["cover_url"]
        operators           <- map["operators"]
        participants        <- map["participants"]
        max_length_message  <- map["max_length_message"]
        freeze              <- map["freeze"]
    }
}

