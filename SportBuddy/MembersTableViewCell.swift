//
//  MembersTableViewCell.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/4/19.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class MembersTableViewCell: UITableViewCell, Identifiable {

    @IBOutlet weak var collectionView: UICollectionView!

    // MARK: Property

    class var identifier: String { return String(describing: self) }

    static let height: CGFloat = 200.0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
