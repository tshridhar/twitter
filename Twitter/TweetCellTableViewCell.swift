//
//  TweetCellTableViewCell.swift
//  Twitter
//
//  Created by KimNgan Nguyen on 4/27/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetCellTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    var liked:Bool = false
    var tweetID:Int = -1
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    
    
    @IBAction func likeTweet(_ sender: Any) {
        let toBeLiked = !liked
        if (toBeLiked) {
            TwitterAPICaller.client?.likeTweet(tweetID: tweetID, success: {
                self.setLiked(true)
            }, failure: { (error) in
                print("Like did not succeed: \(error)")
            })
        } else {
            TwitterAPICaller.client?.unlikeTweet(tweetID: tweetID, success: {
                self.setLiked(false)
            }, failure: { (error) in
                print("Unlike did not succeed: \(error)")
            })
        }
    }
    
    func setLiked(_ isLiked:Bool) {
        liked = isLiked
        if (liked) {
            likeButton.setImage(UIImage(named:"favor-icon-red"), for: UIControl.State.normal)
        } else {
            likeButton.setImage(UIImage(named:"favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted:Bool) {
        if (isRetweeted) {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
 

    
    @IBAction func retweet(_ sender: Any) {
        TwitterAPICaller.client?.retweet(tweetID: tweetID, success: {
            self.setRetweeted(true)
        }, failure: { (error) in
            print("Error is retweeting: \(error)")
            
        })
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
