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
        print("Pressed button)")
        tweet.reTweeted! = !tweet.reTweeted!
        print("Clicked the retweet")
        if (self.tweet.reTweeted!) {
            
            self.tweet.reTweetCount += 1
            reTweetButton.setImage(UIImage(named: "retweet-icon-green"), for: .normal)
        } else {
            self.tweet.reTweetCount -= 1
            reTweetButton.setImage(UIImage(named: "retweet-icon"), for: .normal)
        }
        
        // update rtcount
        self.tweet.reTweetCountString = "\(self.tweet.reTweetCount)"
        reTweetLabel.text = self.tweet.reTweetCountString
    }
    
    
    
    @IBAction func favButton(_ sender: Any) {
        self.tweet.favTweeted = !self.tweet.favTweeted!
        
        if (self.tweet.favTweeted!) {
            self.tweet.favCount += 1
            favButton.setImage(UIImage(named: "favor-icon-1"), for: .normal)
        } else {
            self.tweet.favCount -= 1
            favButton.setImage(UIImage(named: "favor-icon"), for: .normal)
        }
        
        // update favCount
        self.tweet.favCountString = "\(self.tweet.favCount)"
        likePhotoLabel.text = self.tweet.favCountString
    }
    
    /*
    @IBAction func didPressRetweet(_ sender: UIButton) {
     
        
    }
    @IBAction func didPressFavorite(_ sender: UIButton) {
     
        
    }
 */

}
