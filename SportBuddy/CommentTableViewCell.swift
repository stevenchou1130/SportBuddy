//
//  CommentTableViewCell.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/29.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell, Identifiable {

    // MARK: Property

    class var identifier: String { return String(describing: self) }

    static let height: CGFloat = 200.0

    @IBOutlet weak var courtAddress: UILabel!
    @IBOutlet weak var courtTel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
