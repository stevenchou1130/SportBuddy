//
//  WeatherTableViewCell.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/29.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell, Identifiable {

    // MARK: Property

    class var identifier: String { return String(describing: self) }

    static let height: CGFloat = 100.0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        // todo: Get weather API
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
