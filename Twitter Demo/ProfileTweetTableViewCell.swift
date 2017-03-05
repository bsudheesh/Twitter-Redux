//
//  ProfileTweetTableViewCell.swift
//  Twitter Demo
//
//  Created by Sudheesh Bhattarai on 3/5/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit

class ProfileTweetTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    var profileId: Int?
    var delegate: TweetsViewCell?
    
    var tweet: Tweet! {
        didSet {
            
            if let profileImageURL = tweet.profileImageUrl{
                let imageURL = URL(string: profileImageURL as! String)
                profileImageView.setImageWith(imageURL! as URL!)
            }
            else{
                profileImageView.image = nil
            }
            tweetsLabel.text = tweet.text as String?
            userNameLabel.text = "@\(tweet.userName!)"
            dateLabel.text = "\(tweet.timestamp)"
            nameLabel.text = tweet.screenName
            profileId = tweet.profileId
            
            let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(profileTapped))
            profileImageView.isUserInteractionEnabled = true
            profileImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func profileTapped(){
        
        delegate?.selectedProfileId = profileId
        
        //delegate?.performSegue(withIdentifier: "profileViewSegue", sender: delegate)
    }

}
