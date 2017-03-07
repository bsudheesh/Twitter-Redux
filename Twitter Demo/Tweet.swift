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
    
    var profileImageUrlString: NSString?
    var backgroundImageUrlString: NSString?
    var profileUrl: URL?
    var backgroundImageURL: URL?
    
    var screenName: String?
    var reTweetCount: Int = 0
    var reTweetCountString: String = ""
    var favCount: Int = 0
    var favCountString: String = ""
    var rtStatus: NSDictionary?
    var reTweeted: Bool?
    var favTweeted: Bool?
    var retweeted_status: Tweet?
    var id_str: String?
   var current_user_retweet: Tweet?
    var profileId: Int?
    var tweetCount: Int?
    var followingCount: Int?
    var followersCount: Int?

   
    static var tweets = [Tweet]()
    
    
    
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
        tweetCount = tempString?["statuses_count"] as? Int
        profileImageUrlString = tempString?["profile_image_url_https"] as? NSString
        if let profileImageUrlString = profileImageUrlString{
            profileUrl = NSURL(string: profileImageUrlString as String) as URL?
        }
        
        profileId = dictinary["id"] as? Int
        screenName = tempString?["screen_name"] as? NSString as String?
        favCount = (dictinary["favorite_count"] as? Int) ?? 0
        id_str = dictinary["id_str"] as? String
        backgroundImageUrlString = dictinary["profile_background_image_url"] as? String as NSString?
        if let backgroundImageUrlString = backgroundImageUrlString{
            backgroundImageURL = NSURL(string: backgroundImageUrlString as String) as URL?
        }
        followersCount = tempString?["followers_count"] as? Int
        followingCount = tempString?["friends_count"] as? Int
        
        
        let current_user_retweet_dict = (dictinary["current_user_retweet"] as? NSDictionary)
        if current_user_retweet_dict != nil {
            current_user_retweet = Tweet(dictinary: current_user_retweet_dict!)
        } else {
            current_user_retweet = nil
        }
        
        rtStatus = dictinary["retweeted_status"] as? NSDictionary
        
        
        let retweeted_status_dict = (dictinary["retweeted_status"] as? NSDictionary) ?? nil
        if retweeted_status_dict != nil {
            retweeted_status = Tweet(dictinary: retweeted_status_dict!)
        } else {
            retweeted_status = nil
        }
        
        
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
        
        //print("The fav Count is : ", favCount, "The retweet count is : ", retweetCount)
        reTweetCountString = (reTweetCount >= 0) ? "\(reTweetCount)" : ""
        favCountString = (favCount >= 0) ? "\(favCount)" : ""

        
        
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        
        for dictinary in dictionaries{
            let tweet = Tweet(dictinary: dictinary)
            print(dictinary)
            tweets.append(tweet)
        }
        
        return tweets
        
    }

    

}
