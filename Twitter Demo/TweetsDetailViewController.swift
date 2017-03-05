//
//  TweetsDetailViewController.swift
//  Twitter Demo
//
//  Created by Sudheesh Bhattarai on 3/4/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit

class TweetsDetailViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var tweetsLabel: UILabel!
    
    
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var reTweetLabel: UILabel!
    
    
    @IBOutlet weak var favLabel: UILabel!
    
    
    @IBOutlet weak var replyButton: UIButton!
    
    
    @IBOutlet weak var favButton: UIButton!
    
    @IBOutlet weak var reTweetButton: UIButton!
     var retweeted: Bool?
    var favorite: Bool?
    
    
    var tweets: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //userNameLabel.text = tweets.userName as! String
        
        let baseURL = tweets.profileImageUrl
        let imageURL = URL(string: baseURL as! String)
        profileImageView.setImageWith(imageURL! as URL!)
        var tempString : String
        tempString = tweets.screenName as String!
        tempString = "@" + tempString
        userNameLabel.text = tempString
        retweeted = tweets.reTweeted
        favorite = tweets.favTweeted
        
        nameLabel.text = tweets.userName as String!
        
        tweetsLabel.text = tweets.text as String?
        tweetsLabel.sizeToFit()
        
        reTweetLabel.text = tweets.reTweetCountString
        favLabel.text = tweets.favCountString
        
        if self.retweeted! {
            reTweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        }
        else {
            reTweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
        }
        
        if self.favorite! {
            favButton.setImage(UIImage(named: "favor-icon-1"), for: .normal)
        }
        else {
            favButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        }
        reTweetLabel.text = "\(tweets.retweetCount)"
        favLabel.text = "\(tweets.favCount)"
        
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func reTweetButton(_ sender: Any) {
        
        self.retweeted = !self.retweeted!
        if let tweetID = self.tweets {
            TwitterClient.sharedInstance?.reTweet(retweeting: self.retweeted!, tweetID: tweets.id_str!)
            //print(tweetID)
            //print(self.retweeted!)
        }
        
        if self.retweeted! {
            reTweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            tweets.retweetCount += 1
            reTweetLabel.text = "\(tweets.retweetCount)"
        }
        else {
            reTweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
            tweets.retweetCount -= 1
            reTweetLabel.text = "\(tweets.retweetCount)"
        }
    }
    
    
    
    @IBAction func favButton(_ sender: Any) {
        
        self.favorite = !self.favorite!
        if let tweetID = self.tweets {
            TwitterClient.sharedInstance?.favoritePost(favoriting: self.favorite!, tweetID: tweets.id_str!)
        }
        
        if self.favorite! {
            favButton.setImage(UIImage(named: "favor-icon-1"), for: .normal)
            tweets.favCount += 1
            favLabel.text = "\(tweets.favCount)"
        }
        else {
            favButton.setImage(UIImage(named: "favor-icon"), for: .normal)
            tweets.favCount -= 1
            favLabel.text = "\(tweets.favCount)"
        }
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
