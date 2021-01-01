//
//  InstagramPostDetailCollectionViewCell.swift
//  ImitateInstagram
//
//  Created by Marso on 2020/12/31.
//

import UIKit

class InstagramPostDetailCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var showPostImageView: UIImageView!
    @IBOutlet weak var postPicCellWidthConstraints: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        postPicCellWidthConstraints?.constant = UIScreen.main.bounds.width
    }
    
}
