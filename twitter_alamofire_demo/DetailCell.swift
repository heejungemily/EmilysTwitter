//
//  DetailCell.swift
//  twitter_alamofire_demo
//
//  Created by Emily Heejung Son on 3/14/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class DetailCell: UITableViewCell {

 
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var replyButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var tweet: Tweet! {
        didSet {
            tweetLabel.text = tweet.text
            usernameLabel.text = "@\(tweet.user.screenName)"
            nameLabel.text = tweet.user.name
            dateLabel.text = tweet.createdAtString
            if let url = tweet.user.profileImageUrl {
                profileImageView.af_setImage(withURL: url)

            }
            
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
