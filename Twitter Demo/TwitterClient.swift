//
//  TwitterClient.swift
//  Twitter Demo
//
//  Created by Sudheesh Bhattarai on 2/25/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "xWZCWjpp7OMBCN5A5GdpB4tFY", consumerSecret: "e365Yb1G8brF12GJO76F6nvA9NiLLeaN3PrQUImm2LmmlgXrW7")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    
    func handleOpenUrl(url: NSURL){
        let requesToken = BDBOAuth1Credential(queryString: url.query)
        
        fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requesToken, success: {
            (requestToken: BDBOAuth1Credential?) -> Void in
            
            self.currentAccount(success: { (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
            }, failure : { (error : NSError) -> () in
                self.loginFailure?(error as! NSError)
            })
                
            
            
            
            
        }, failure: { (error: Error?) -> Void in
            print ("Error \(error!.localizedDescription)")
            self.loginFailure?(error as! NSError)
        })

    }
    
    func homeTimeLine(success: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> ()){
        
        
        get("1.1/statuses/home_timeline.json", parameters: nil,progress: nil, success: { (task: URLSessionDataTask, response: Any?) -> Void in
            let dictionaries = response as! [NSDictionary]
            print("Inside tweets")
            let tweets = Tweet.tweetsWithArray(dictionaries: dictionaries)
            
            success(tweets)
            
        }, failure: { (task: URLSessionDataTask?, error: Error) ->  Void in
            failure(error as NSError)
            
        })
        
        
        
        
        
    }
    
    func login(success: @escaping () -> (), failure: @escaping (NSError) -> ()){
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance?.deauthorize()
        TwitterClient.sharedInstance?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterDemo://oauth") as URL!, scope: nil, success: { (requestToken:
            BDBOAuth1Credential?) -> Void in
            print("I have got a token")
            let temp = requestToken!.token as String!
            print("The token is : ", temp!)
            let url = NSURL (string: "https://api.twitter.com/oauth/authorize?oauth_token=\(temp!)")!
            //openURL is used to open a new webpage, maps etc
            UIApplication.shared.openURL(url as URL)
            
        }) {(error : Error?) -> Void in
            print("error: \(error?.localizedDescription)")
            self.loginFailure?(error as! NSError)
        }

    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (NSError) -> ()){
        get("1.1/account/verify_credentials.json", parameters: nil,progress: nil, success: {(task: URLSessionDataTask, response: Any?) -> Void in
            // print("account: \(response)")
            let userDictionary = response as! NSDictionary
            
            let user = User(dictionary: userDictionary)
            success(user)
            
        }, failure: {( task: URLSessionDataTask?, error: Error) -> Void in
            failure(error as NSError)
        })
    }

}
