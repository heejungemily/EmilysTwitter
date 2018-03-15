//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var id: Int
   
    var screenName: String
    var profileImageUrl: URL?
    var profileBackgroundImageUrl: URL?
    var statusesCount: Int?
    var friendsCount: Int?
    var followersCount: Int?
    
    init(dictionary: [String: Any]) {
        id = dictionary["id"] as! Int
        name = dictionary["name"] as! String
        screenName = dictionary["screen_name"] as! String
        var url = dictionary["profile_image_url"] as? String
        profileImageUrl = URL(string: url ?? "")
        
        url = dictionary["profile_background_image_url"] as? String
        profileBackgroundImageUrl = URL(string: url ?? "")
        
        statusesCount = dictionary["statuses_count"] as? Int
        friendsCount = dictionary["friends_count"] as? Int
        followersCount = dictionary["followers_count"] as? Int
    }
    
   
}
