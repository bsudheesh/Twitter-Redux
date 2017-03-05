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
    
    @IBOutlet weak var tableView: UITableView!
    //@IBOutlet weak var tableCell: UITableViewCell!
    //@IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var profilePicture: UIImageView!
    
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
        
        if let profileImageURL = user.profileUrl {
            bigPicture.setImageWith(profileImageURL as URL)
            bigPicture.layer.zPosition = 1
        } else {
            bigPicture.image = nil
        }
        
        if let headerImageURL = user.headerPicUrl {
            profilePicture.setImageWith(headerImageURL)
        } else {
            profilePicture.image = nil
        }
        
        
        TwitterClient.sharedInstance?.getUserTweets(id: user.id!, success: { (response: [Tweet]) in
            print("tweets: \(response)")
            self.tweets = response
            self.tableView.reloadData()
        }, failure: { (error:Error) in
            print("error: \(error)")
        })
    }

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 85
        tableView.reloadData()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var bigPicture: UIImageView!

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
        //cell.tweet = tweet
        //print("cell.profile: \(cell.profileImageView.image)")
        return cell
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
