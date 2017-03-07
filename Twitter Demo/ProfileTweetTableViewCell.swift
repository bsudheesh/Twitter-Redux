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
    var tweets: Tweet!
    
    
    
    
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
