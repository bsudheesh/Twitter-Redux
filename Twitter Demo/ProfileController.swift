//
//  ProfileController.swift
//  Twitter Demo
//
//  Created by Sudheesh Bhattarai on 3/6/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit

class ProfileController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var user: User!
    
    @IBOutlet weak var profileImageUrl: UIImageView!

    
    @IBOutlet weak var bigImageURL: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var followersLabel: UILabel!
    
    @IBOutlet weak var followingLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tweetLabel: UILabel!
    var tweets: [Tweet]! = []

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        nameLabel.text = user.name! as String//user.name! as String
        nameLabel.layer.zPosition = 1
        userNameLabel.text = "@\((user.screenName!))"
        userNameLabel.layer.zPosition = 1
        
        tweetLabel.text = String((user.tweetCount)! as Int)
        followersLabel.text = String((user.followersCount)! as Int)
        
        followingLabel.text = String((user.followingCount)! as Int)
        bigImageURL.isOpaque = false
        /*
        if let profileImageURL = user.backgroundImageURL {
            bigImageURL.setImageWith(profileImageURL as URL)
            bigImageURL.layer.zPosition = 1
        } else {
            bigImageURL.image = nil
        }
 */
        
        if let headerImageURL = user.profileUrl {
            profileImageUrl.setImageWith(headerImageURL as URL)
        } else {
            profileImageUrl.image = nil
        }
        profileImageUrl.isOpaque = false
        
        
        TwitterClient.sharedInstance?.getTweetsFromUser(screemID: user.screenName!, success: { (response: [Tweet]) in
            
            self.tweets = response
            for tweet in self.tweets{
                print("The screenname is : ", tweet.screenName)
            }
            
            self.tableView.reloadData()
        }, failure: { (error:Error) in
            print("error: \(error)")
        })
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        
        return self.tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileIdentifier", for: indexPath) as! ProfileTableViewCell
        let tweet = self.tweets[indexPath.row]
        cell.userImage.setImageWith(tweet.profileUrl!)
        cell.tweetsLabel.text = tweet.text as String?
        cell.tweetsLabel.sizeToFit()
        cell.userNameLabel.text = "@\(tweet.screenName!)"
        cell.userNameLabel.sizeToFit()
        
        if tweet.timestamp != nil{
            cell.dateLabel.text = TwitterClient.tweetTimeFormatted(timestamp: tweet.timestamp as! Date)
        }
        
        cell.dateLabel.sizeToFit()
        cell.nameLabel.text = tweet.userName as String?
        cell.nameLabel.sizeToFit()
            
        
               return cell
    }

    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "homeToMain"{
        }
        else{
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let tweet = tweets![(indexPath!.row)]
            let detailViewController = segue.destination as! ProfileTableViewCell
            // Get the new view controller using segue.destinationViewController.
            // Pass the selected object to the new view controller.

        }
    }
    

}
