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
    var user: User!
    var tweets: [Tweet]! = []
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        nameLabel.text = user.name! as String
        nameLabel.layer.zPosition = 1
        userNameLabel.text = "@\((user.screenName!))"
        userNameLabel.layer.zPosition = 1
        
        tweetLabel.text = String((user.tweetCount)! as Int)
        followersLabel.text = String((user.followersCount)! as Int)
        
        followingLabel.text = String((user.followingCount)! as Int)
        
        if let profileImageURL = user.backgroundImageURL {
            backgroundPicture.setImageWith(profileImageURL as URL)
            backgroundPicture.layer.zPosition = 1
        } else {
            backgroundPicture.image = nil
        }
        
        if let headerImageURL = user.profileUrl {
            profilePicture.setImageWith(headerImageURL as URL)
        } else {
            profilePicture.image = nil
        }
        
        
        TwitterClient.sharedInstance?.getTweetsFromUser(screemID: user.screenName!, success: { (response: [Tweet]) in
            
            self.tweets = response
            for tweet in self.tweets{
                print("User tweet : ", tweet.text!)
            }
            
            self.tableView.reloadData()
        }, failure: { (error:Error) in
            print("error: \(error)")
        })
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
        
        if let profileImageURL = tweet.profileImageUrl{
            let imageURL = URL(string: profileImageURL as! String)
            cell.profileImageView.setImageWith(imageURL! as URL!)
        }
        else{
            cell.profileImageView.image = nil
        }
        cell.tweetsLabel.text = tweet.text as String?
        cell.tweetsLabel.sizeToFit()
        cell.userNameLabel.text = "@\(tweet.screenName!)"
        cell.userNameLabel.sizeToFit()
        
        if tweet.timestamp != nil{
            cell.dateLabel.text = TwitterClient.tweetTimeFormatted(timestamp: tweet.timestamp as! Date)
        }
        
        cell.dateLabel.sizeToFit()
        cell.nameLabel.text = tweet.userName
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
