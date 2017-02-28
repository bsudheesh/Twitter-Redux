//
//  TweetsViewController.swift
//  Twitter Demo
//
//  Created by Sudheesh Bhattarai on 2/25/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit
import AFNetworking

class TweetsViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationController?.navigationBar.barTintColor = UIColor.purple
        navigationController?.navigationBar.barTintColor = UIColor.black
        navigationController?.navigationBar.isTranslucent = false
        
        tableView.dataSource = self
        tableView.delegate = self
        
        
        TwitterClient.sharedInstance?.homeTimeLine(success: { (tweets: [Tweet]) -> () in
            self.tweets = tweets
            for tweet in tweets{
                print(tweet.text)
                print(tweet)
                
            }
        }, failure: { (error: NSError) -> () in
            print(error.localizedDescription)
        })

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onLogoutButton(_ sender: Any) {
        TwitterClient.sharedInstance?.logOut()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath as IndexPath) as! TweetsViewCell
        cell.tweetsLabel.text = "HI! This is not working"
        cell.userNameLabel.text = "Kushal Poudyal"
        if(tweets != nil){
            let tweetsTemp = tweets[indexPath.row]
            let baseURL = tweetsTemp.profileImageUrl
            
            let imageURL = URL(string: baseURL as! String)
            cell.profilePictureLabel.setImageWith(imageURL! as URL!)
            print("The image URL is : ", imageURL!)
            
            
            cell.tweetsLabel.text = tweetsTemp.text as String!
            cell.userNameLabel.text = tweetsTemp.userName as String!
            cell.tweetsLabel.sizeToFit()
            cell.tweetsLabel.adjustsFontSizeToFitWidth = true
            cell.userNameLabel.sizeToFit()
            cell.userNameLabel.adjustsFontSizeToFitWidth = true
        }
        else{
            print("Tweets are nill")
        }
        
        
        
        
        
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
