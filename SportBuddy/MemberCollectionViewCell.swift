//
//  MemberCollectionViewCell.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/4/19.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class MemberCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        userImage.layer.cornerRadius = userImage.bounds.size.height / 2.0
        userImage.layer.masksToBounds = true

        userName.textColor = .white
    }

}
