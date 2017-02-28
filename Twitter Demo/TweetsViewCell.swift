//
//  TweetsViewCell.swift
//  Twitter Demo
//
//  Created by Sudheesh Bhattarai on 2/27/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit

class TweetsViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var profilePictureLabel: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var tweet: Tweet!{
        didSet{
            print("It did set")
            
            let baseURL = tweet.profileImageUrl
            
            let imageURL = URL(string: baseURL as! String)
            profilePictureLabel.setImageWith(imageURL! as URL!)
            print("The image URL is : ", imageURL!)
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
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
