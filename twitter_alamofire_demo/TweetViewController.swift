//
//  TweetViewController.swift
//  twitter_alamofire_demo
//
//  Created by Emily Heejung Son on 3/14/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class TweetViewController: UIViewController, UITextViewDelegate {
    static let TWEET = 0
    static let REPLY = 1
    
    @IBOutlet weak var charCountBarButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileView: UIImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetTextView: UITextView!
    
    var mode: Int = TweetViewController.TWEET
    var tweet: Tweet?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTextView.delegate = self
        tweetTextView.becomeFirstResponder()
        tweetTextView.text = ""
        
        profileView.layer.cornerRadius = 10.0
        
        getUser()
        

        // Do any additional setup after loading the view.
    }
  
    
    
    
    @IBAction func tweet(_ sender: Any) {
        if mode == TweetViewController.REPLY {
            APIManager.shared.composeReply(with: tweetTextView.text, tweet: tweet!, completion: { (tweet, error) in
                self.dismiss(animated: true, completion: nil)
                
            })
        }
        else if mode == TweetViewController.TWEET {
            APIManager.shared.composeTweet(with: tweetTextView.text, completion: { (tweet, error) in
                self.dismiss(animated: true, completion: nil)
            })
            
        }
    }
    
    func getUser() {
        APIManager.shared.getCurrentAccount { (user, error) in
            if let user = user {
                if let url = user.profileImageUrl {
     
                    self.profileView.af_setImage(withURL: url)
                    
                    
                }
                
                self.nameLabel.text = user.name
                self.usernameLabel.text = "@\(user.screenName)"
                
            }
        }
    }
    

func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    let characterLimit = 140
    
    let newText = NSString(string: textView.text!).replacingCharacters(in: range, with: text)
    
    let remainingChar = characterLimit - newText.characters.count
    charCountBarButton.title = "\(remainingChar)"
    
    return newText.characters.count < characterLimit
}
    
    @IBAction func cancel(_ sender: Any) {

        self.dismiss(animated: true, completion: nil)
        
    }
    /*
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
