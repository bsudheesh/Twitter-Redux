//
//  TweetsViewCell.swift
//  Twitter Demo
//
//  Created by Sudheesh Bhattarai on 2/27/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit

class TweetsViewCell: UITableViewCell {

    @IBOutlet weak var replyImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var profilePictureLabel: UIImageView!
    @IBOutlet weak var reTweetLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var likePhotoLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    
    var selectedProfileId: Int?
    var retweeted: Bool?
    var favorite: Bool?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var reTweetButton: UIButton!
    
    
    
    var tweet: Tweet!{
        didSet{
            
            
            let baseURL = tweet.profileImageUrl
            
            let imageURL = URL(string: baseURL as! String)
            profilePictureLabel.setImageWith(imageURL! as URL!)
            var tempScreenName: String
            tempScreenName = tweet.screenName as String!
            tempScreenName = "@" + tempScreenName
            
            tweetsLabel.text = tweet.text as String!
            userNameLabel.text = tweet.userName as String!
            screenNameLabel.text = tempScreenName as String!
            tweetsLabel.sizeToFit()
            tweetsLabel.adjustsFontSizeToFitWidth = true
            userNameLabel.sizeToFit()
            userNameLabel.adjustsFontSizeToFitWidth = true
            screenNameLabel.sizeToFit()
            screenNameLabel.adjustsFontSizeToFitWidth = true
            if tweet.timestamp != nil{
                timeLabel.text = TwitterClient.tweetTimeFormatted(timestamp: tweet.timestamp as! Date)
            }
            
            retweeted = tweet.reTweeted
            favorite = tweet.favTweeted
            
            
            reTweetLabel.text = tweet.reTweetCountString
            likePhotoLabel.text = tweet.favCountString
            
            if (!self.tweet.reTweeted!) {
                reTweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
            } else {
                reTweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            }
            if (!self.tweet.favTweeted!) {
                favButton.setImage(UIImage(named: "favor-icon"), for: .normal)
            } else {
                favButton.setImage(UIImage(named: "favor-icon-1"), for: .normal)
            }
            
            
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func reTweetButton(_ sender: Any) {
        
        self.retweeted = !self.retweeted!
        if let tweetID = self.tweet {
            TwitterClient.sharedInstance?.reTweet(retweeting: self.retweeted!, tweetID: tweet.id_str!)
            //print(tweetID)
            //print(self.retweeted!)
        }
        
        if self.retweeted! {
            reTweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
            tweet.retweetCount += 1
            reTweetLabel.text = "\(tweet.retweetCount)"
        }
        else {
            reTweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
            tweet.retweetCount -= 1
            reTweetLabel.text = "\(tweet.retweetCount)"
        }

    }
    
    
    
    @IBAction func favButton(_ sender: Any) {
        self.favorite = !self.favorite!
        if let tweetID = self.tweet {
            TwitterClient.sharedInstance?.favoritePost(favoriting: self.favorite!, tweetID: tweet.id_str!)
        }
        
        if self.favorite! {
            favButton.setImage(UIImage(named: "favor-icon-1"), for: .normal)
            tweet.favCount += 1
            likePhotoLabel.text = "\(tweet.favCount)"
        }
        else {
            favButton.setImage(UIImage(named: "favor-icon"), for: .normal)
            tweet.favCount -= 1
            likePhotoLabel.text = "\(tweet.favCount)"
        }
    }
}
