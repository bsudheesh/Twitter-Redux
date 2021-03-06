//
//  ProfileViewController.swift
//  Twitter Demo
//
//  Created by Sudheesh Bhattarai on 3/5/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    //@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backgroundPicture: UIImageView!
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    var tweet: Tweet!
    var tweets: [Tweet]! = []
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        nameLabel.text = tweet.userName! as String//user.name! as String
        nameLabel.layer.zPosition = 1
        userNameLabel.text = "@\((tweet.screenName!))"
        userNameLabel.layer.zPosition = 1
        
        tweetLabel.text = String((tweet.tweetCount)! as Int)
        followersLabel.text = String((tweet.followersCount)! as Int)
        
        followingLabel.text = String((tweet.followingCount)! as Int)
        
        if let profileImageURL = tweet.backgroundImageURL {
            backgroundPicture.setImageWith(profileImageURL as URL)
            backgroundPicture.layer.zPosition = 1
        } else {
            backgroundPicture.image = nil
        }
        
        if let headerImageURL = tweet.profileUrl {
            profilePicture.setImageWith(headerImageURL as URL)
        } else {
            profilePicture.image = nil
        }
        
        
        TwitterClient.sharedInstance?.getTweetsFromUser(screemID: tweet.screenName!, success: { (response: [Tweet]) in
            
            self.tweets = response
            for tweet in self.tweets{
                print("The screenname is : ", tweet.screenName)
            }
            
            self.tableView.reloadData()
        }, failure: { (error:Error) in
            print("error: \(error)")
        })
    }

    
    
    @IBAction func logoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logOut()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Inside the did load")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()

        // Do any additional setup after loading the view.
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTweetViewCell", for: indexPath) as! ProfileTweetTableViewCell
        let tweet = self.tweets[indexPath.row]
        cell.profileImageView.setImageWith(tweet.profileUrl!)
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
        cell.profileId = tweet.profileId
        

        
        //cell.tweet = tweet
        //print("cell.profile: \(cell.profileImageView.image)")
        return cell
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let tweet = tweets![(indexPath!.row)]
        let detailViewController = segue.destination as! ProfileTweetTableViewCell
        
        
        detailViewController.tweets = tweet
        
        
    }
    

}
