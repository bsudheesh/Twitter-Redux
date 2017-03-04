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
        
        nameLabel.text = tweets.userName as String!
        
        tweetsLabel.text = tweets.text as String?
        tweetsLabel.sizeToFit()
        
        reTweetLabel.text = tweets.reTweetCountString
        favLabel.text = tweets.favCountString
        
                
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
