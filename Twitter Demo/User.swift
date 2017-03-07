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
    var screenName: String?
    var profileUrl: NSURL?
    var backgroundImageURL: URL?
    var tagLine: NSString?
    var dictionary: NSDictionary?
    var headerPicUrl: URL?
    var id: Int?
    var tweetCount: Int?
    var followingCount: Int?
    var followersCount: Int?
    
    
    static let userDidLogoutNotification = "UserDidLogout"
    
    
    
    init(dictionary: NSDictionary){
        self.dictionary = dictionary
        name = dictionary["name"] as? NSString
        screenName = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_background_image_url_https"] as? NSString //profile_banner_url
        if let profileUrlString = profileUrlString{
            profileUrl = NSURL(string: profileUrlString as String)
        }
        tagLine = dictionary["description"] as? NSString
        tweetCount = dictionary["statuses_count"] as? Int
        followersCount = dictionary["followers_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        let headerPicUrlString = dictionary["profile_banner_url"] as? String //profile_image_url_https
        if let headerPicUrlString = headerPicUrlString {
            headerPicUrl = URL(string: headerPicUrlString)
            id = dictionary["id"] as? Int
        }
        
        let backgroundImageURLString = dictionary["profile_background_image_url_https"] as? String
        if let backgroundImageURLString = backgroundImageURLString {
            self.backgroundImageURL = URL(string: backgroundImageURLString)
        }
        
        
    }
    static var _currentUser: User?
    
    
    class var currentUser: User? {
        get{
            if _currentUser == nil{
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? NSData //if there is user, return it
                if let userData = userData{ //turn back to user and store to currentUser
                    do{
                        let dictionary =  try JSONSerialization.jsonObject(with: userData as Data, options: []) as! NSDictionary
                        _currentUser = User(dictionary: dictionary)
                        
                    }
                    catch let error as NSError{
                        print("Caught error" , error.localizedDescription)
                    }
                    
                }
            }
            return _currentUser
            
                
        }
     
        set(user){
            _currentUser = user
            let defaults = UserDefaults.standard
            if let user = user{ //if user does exits
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
