//
//  InstagramCollectionViewCell.swift
//  ImitateInstagram
//
//  Created by Marso on 2020/12/21.
//

import UIKit

class InstagramCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var showImageView: UIImageView!
    @IBOutlet weak var cellWidthConstraints: NSLayoutConstraint!
    static let width = floor((UIScreen.main.bounds.width - 3 * 2) / 3)
        override func awakeFromNib() {
            super.awakeFromNib()
            cellWidthConstraints?.constant = Self.width
        }
}
