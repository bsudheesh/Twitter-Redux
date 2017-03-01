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
    var screenName: String?
    var reTweetCount: Int = 0
    var reTweetCountString: String = ""
    var favCount: Int = 0
    var favCountString: String = ""
    var rtStatus: NSDictionary?
    var reTweeted: Bool?
    var favTweeted: Bool?
   
    
    
    init(dictinary: NSDictionary) {
        reTweeted = (dictinary["retweeted"] as? Bool) ?? true
        favTweeted = (dictinary["favorited"] as? Bool) ?? false
        text = dictinary["text"] as? NSString
        retweetCount = (dictinary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictinary["favourites_count"] as? Int) ?? 0
        let timeStampString = dictinary["created_at"] as? NSString
        var tempString: NSDictionary?
        tempString = dictinary["user"] as? NSDictionary
        userName = tempString?["name"] as? NSString
        profileImageUrl = tempString?["profile_image_url_https"] as? NSString
        screenName = tempString?["screen_name"] as? NSString as String?
        favCount = (dictinary["favorite_count"] as? Int) ?? 0
        
        rtStatus = dictinary["retweeted_status"] as? NSDictionary
        
        
        if let timeStampString = timeStampString{
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timeStampString as! String) as NSDate?
        }
        
        if let rtStatus = rtStatus {
            reTweetCount = rtStatus["retweet_count"] as? Int ?? 0
            favCount = (rtStatus["favourites_count"] as? Int) ?? 0
        } else {
            reTweetCount = (dictinary["retweet_count"] as? Int) ?? 0
        }
        
        print("The fav Count is : ", favCount, "The retweet count is : ", retweetCount)
        reTweetCountString = (reTweetCount >= 0) ? "\(reTweetCount)" : ""
        favCountString = (favCount >= 0) ? "\(favCount)" : ""

        
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        for dictinary in dictionaries{
            let tweet = Tweet(dictinary: dictinary)
            tweets.append(tweet)
        }
        
        return tweets
        
    }

    

}
