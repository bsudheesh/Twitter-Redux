//
//  User.swift
//  Twitter Demo
//
//  Created by Sudheesh Bhattarai on 2/25/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit

class User: NSObject {
    var name: NSString?
    var screenName: NSString?
    var profileUrl: NSURL?
    var tagLine: NSString?
    
    init(dictionary: NSDictionary){
        
        
        name = dictionary["name"] as? NSString
        screenName = dictionary["screen_name"] as? NSString
        let profileUrlString = dictionary["profile_image_url_https"] as? NSString
        if let profileUrlString = profileUrlString{
            profileUrl = NSURL(string: profileUrlString as String)
        }
        tagLine = dictionary["description"] as? NSString
    }
    
    
}
