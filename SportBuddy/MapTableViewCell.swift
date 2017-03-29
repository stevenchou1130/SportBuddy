//
//  MapTableViewCell.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/29.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import MapKit

class MapTableViewCell: UITableViewCell, Identifiable {

    // MARK: Property

    class var identifier: String { return String(describing: self) }

    static let aspectRatio: CGFloat = 3.0 / 2.0

    @IBOutlet weak var mapView: MKMapView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
