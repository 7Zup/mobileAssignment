//
//  User.swift
//  mobileAssignment
//
//  Created by Fabrice Froehly on 26/12/2017.
//  Copyright © 2017 Fabrice Froehly. All rights reserved.
//

import UIKit
import ObjectMapper

class User: NSObject, NSCopying, Mappable {
    
    var user_id: String?
    var nickname: String?
    var profile_url: String?
    var access_token: String?
    var is_online: Bool?
    var last_seen_at: Int?
    
    required init?(map: Map) {
    }
    
    init(user_id: String?, nickname: String?, profile_url: String?) {
        
        self.nickname = nickname
        self.user_id = user_id
        self.profile_url = profile_url
    }
    
    func mapping(map: Map) {
        
        user_id         <- map["user_id"]
        nickname        <- map["nickname"]
        profile_url     <- map["profile_url"]
        access_token    <- map["access_token"]
        is_online       <- map["is_online"]
        last_seen_at    <- map["last_seen_at"]
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        
        let copy = User(user_id: user_id, nickname: nickname, profile_url: profile_url)
        return copy
    }
}

