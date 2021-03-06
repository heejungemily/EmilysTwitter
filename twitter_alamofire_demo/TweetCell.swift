//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var tweetTextLabel: UILabel!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            if let favorited = tweet.favorited {
                if ( favorited) {
                    favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
                }
                else {
                    favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
                }
            }
            if ( tweet.retweeted) {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
            
            }
            else {
                retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func tapRetweet(_ sender: UIButton) {
        tweet.retweeted = !tweet.retweeted
        if ( tweet.retweeted ) {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon-green"), for: .normal)
            APIManager.shared.retweet(tweet, completion: { (tweet, error) in
                
            })
        }
        else {
            retweetButton.setImage(#imageLiteral(resourceName: "retweet-icon"), for: .normal)
            APIManager.shared.unretweet(tweet, completion: { (tweet, error) in
                
            })
        }
        
        
    }
    @IBAction func tapFavorite(_ sender: UIButton) {
        if let favorited = tweet.favorited {
            tweet.favorited = !favorited
        }
        if let favorited = tweet.favorited {
            if (favorited) {
                favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon-red"), for: .normal)
                APIManager.shared.favorite(tweet, completion: { (tweet, error) in
                    
                })
                
            }
            else {
                favoriteButton.setImage(#imageLiteral(resourceName: "favor-icon"), for: .normal)
                APIManager.shared.unfavorite(tweet, completion: { (tweet, error) in
                    
                })
                
            }
        }
        
        
    }
    
}
