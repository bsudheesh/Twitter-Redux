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
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        
        
        name = dictionary["name"] as? NSString
        screenName = dictionary["screen_name"] as? NSString
        let profileUrlString = dictionary["profile_image_url_https"] as? NSString
        if let profileUrlString = profileUrlString{
            profileUrl = NSURL(string: profileUrlString as String)
        }
        tagLine = dictionary["description"] as? NSString
    }
    static var _currentUser: User?
    
    
    class var currentUser: User? {
        get{
            if _currentUser == nil{
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? NSData //if there is user, return it
                if let userData = userData{ //turn back to user and store to currentUser
                    let dictionary =  try! JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
            
                
        }
     
        set(user){
            _currentUser = user
            let defaults = UserDefaults.standard
            if let user = user{ //if user does exits
                print("Inside if")
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set (data, forKey: "currentUserData")
            }
            else{
                defaults.set (nil, forKey: "currentUserData")
            }
            
            defaults.synchronize() //saves it to disk
            
        }
    }
    
    
}
