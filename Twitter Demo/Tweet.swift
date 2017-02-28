//
//  Tweet.swift
//  Twitter Demo
//
//  Created by Sudheesh Bhattarai on 2/25/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: NSString?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var userName : NSString?
    var profileImageUrl: NSString?
    
    
    init(dictinary: NSDictionary) {
        text = dictinary["text"] as? NSString
        retweetCount = (dictinary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictinary["favourites_count"] as? Int) ?? 0
        let timeStampString = dictinary["created_at"] as? NSString
        var tempString: NSDictionary?
        tempString = dictinary["user"] as? NSDictionary
        userName = tempString?["name"] as? NSString
        profileImageUrl = tempString?["profile_image_url_https"] as? NSString
        print("The user name is : ", userName)
        
        
        if let timeStampString = timeStampString{
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timeStampString as! String) as NSDate?
        }
        
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        for dictinary in dictionaries{
            print("The dictionary is : ", dictinary)
            let tweet = Tweet(dictinary: dictinary)
            tweets.append(tweet)
        }
        
        return tweets
        
    }

    

}
