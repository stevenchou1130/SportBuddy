//
//  GameTableViewCell.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/4/11.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class GameTableViewCell: UITableViewCell {

    @IBOutlet weak var levelImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var peopleNum: UILabel!
    @IBOutlet weak var time: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
