//
//  ComposeViewController.swift
//  Twitter Demo
//
//  Created by Sudheesh Bhattarai on 3/6/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tweetTextView: UITextView!
    
    var tweets: User!
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userImageLevel: UIImageView!
    
    @IBAction func onSaveButton(_ sender: Any) {
        if let text = self.tweetTextView.text {
            TwitterClient.sharedInstance?.sendTweet(text: text, callBack: { (tweet, error) in
                DispatchQueue.main.async {
                    self.view.endEditing(true)
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    
    @IBAction func onCancelButton(_ sender: Any) {
         self.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextView.delegate = self
        tweetTextView.becomeFirstResponder()
        userNameLabel.text = "@\((tweets.screenName!))"
        userNameLabel.sizeToFit()
        nameLabel.text = tweets.name as String?
        nameLabel.sizeToFit()
        userImageLevel.setImageWith(tweets.profileUrl! as URL)

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
