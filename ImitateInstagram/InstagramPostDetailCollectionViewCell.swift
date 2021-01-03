//
//  InstagramPostDetailCollectionViewCell.swift
//  ImitateInstagram
//
//  Created by Marso on 2020/12/31.
//

import UIKit

class InstagramPostDetailCollectionViewCell: UICollectionViewCell {
    var likeButtonStatus: Bool = false
    @IBOutlet weak var showPostImageView: UIImageView!
    @IBOutlet weak var showProfilePicImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postCommentCountLabel: UILabel!
    @IBOutlet weak var postCaptionTextView: UITextView!
    @IBOutlet weak var postLikeLabel: UILabel!
    @IBOutlet weak var postLikeButton: UIButton!
    @IBAction func postLikeButton(_ sender: Any) {
       likeButtonStatus = !likeButtonStatus
        if likeButtonStatus {
            postLikeButton.setImage(UIImage(named: "iconRedLove"), for: UIControl.State.normal)
        }
        else {
            postLikeButton.setImage(UIImage(named: "iconLove"), for: UIControl.State.normal)
        }
    }

    //    @IBOutlet weak var postPicCellWidthConstraints: NSLayoutConstraint!
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        postPicCellWidthConstraints?.constant = UIScreen.main.bounds.width
//    }
    
}
