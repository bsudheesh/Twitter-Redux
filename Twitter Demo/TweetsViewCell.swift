//
//  TweetsViewCell.swift
//  Twitter Demo
//
//  Created by Sudheesh Bhattarai on 2/27/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit

class TweetsViewCell: UITableViewCell {

    @IBOutlet weak var profilePictureLabel: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
