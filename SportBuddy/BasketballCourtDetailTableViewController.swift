//
//  BasketballCourtDetailTableViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/29.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class BasketballCourtDetailTableViewController: BaseTableViewController {

    enum Component {

        case weather, map, comment

    }

    // MARK: Property

    var components: [Component] = [ .weather, .map, .comment ]

    var basketballCourt: BasketballCourt?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }

    func setUp() {

        // 分隔線
        // tableView.separatorStyle = .none

        let weatherNib = UINib(nibName: WeatherTableViewCell.identifier, bundle: nil)
        tableView.register(weatherNib, forCellReuseIdentifier: WeatherTableViewCell.identifier)

        let mapNib = UINib(nibName: MapTableViewCell.identifier, bundle: nil)
        tableView.register(mapNib, forCellReuseIdentifier: MapTableViewCell.identifier)

        let commentNib = UINib(nibName: CommentTableViewCell.identifier, bundle: nil)
        tableView.register(commentNib, forCellReuseIdentifier: CommentTableViewCell.identifier)

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return components.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch components[section] {
        case .weather, .map, .comment:

            return 1
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch components[indexPath.section] {
        case .weather:

            return WeatherTableViewCell.height

        case .map:

            let width = view.bounds.size.width

            let height = width / MapTableViewCell.aspectRatio

            return height

        case .comment:

            return CommentTableViewCell.height
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let component = components[indexPath.section]

        switch component {
        case .weather:

            let identifier = WeatherTableViewCell.identifier

            // swiftlint:disable force_cast
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! WeatherTableViewCell
            // swiftlint:enable force_cast

            cell.selectionStyle = .none

            return cell

        case .map:

            let identifier = MapTableViewCell.identifier

            // swiftlint:disable force_cast
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MapTableViewCell
            // swiftlint:enable force_cast

            cell.selectionStyle = .none

            if let latitudeString = basketballCourt?.latitude,
                let longitudeString = basketballCourt?.longitude {

                let latitude = (latitudeString as NSString).doubleValue
                let longitude = (longitudeString as NSString).doubleValue

                let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                cell.mapView.addAnnotation(annotation)

                let latDelta: CLLocationDegrees = 0.01
                let lonDelta: CLLocationDegrees = 0.01
                let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
                let region: MKCoordinateRegion = MKCoordinateRegionMake(coordinate, span)

                cell.mapView.setRegion(region, animated: true)
                cell.mapView.mapType = .standard
            }

            return cell

        case .comment:

            let identifier = CommentTableViewCell.identifier

            // swiftlint:disable force_cast
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CommentTableViewCell
            // swiftlint:enable force_cast

            cell.selectionStyle = .none

            if let address = basketballCourt?.address,
                let tel = basketballCourt?.tel {

                cell.courtAddress.text = "地址 : \(address)"
                cell.courtTel.text = "電話 : \(tel)"

                cell.courtAddress.adjustsFontSizeToFitWidth = true
                cell.courtTel.adjustsFontSizeToFitWidth = true
            }

            return cell
        }

    }
}
