//
//  LoginViewController.swift
//  Twitter Demo
//
//  Created by Sudheesh Bhattarai on 2/25/17.
//  Copyright © 2017 Sudheesh Bhattarai. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLoginButton(_ sender: Any) {
        let twitterClient = BDBOAuth1SessionManager(baseURL: NSURL(string: "https://api.twitter.com")! as URL!, consumerKey: "xWZCWjpp7OMBCN5A5GdpB4tFY", consumerSecret: "e365Yb1G8brF12GJO76F6nvA9NiLLeaN3PrQUImm2LmmlgXrW7")
        
        twitterClient?.deauthorize()
        twitterClient?.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterDemo://oauth") as URL!, scope: nil, success: { (requestToken:
            BDBOAuth1Credential?) -> Void in
            print("I have got a token")
            let temp = requestToken!.token as String!
            print("The token is : ", temp!)
            let url = NSURL (string: "https://api.twitter.com/oauth/authorize?oauth_token=\(temp!)")!
            //openURL is used to open a new webpage, maps etc
            UIApplication.shared.openURL(url as URL)
                                                    
        }) {(error : Error?) -> Void in
            print("error")
        }

        
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
