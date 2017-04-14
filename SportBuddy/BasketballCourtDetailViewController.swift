//
//  BasketballCourtDetailViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/4/14.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class BasketballCourtDetailViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    enum Component {

        case weather, map, comment

    }

    // MARK: Property

    var components: [Component] = [ .weather, .map, .comment ]

    var basketballCourt: BasketballCourt?
    var weather: Weather?

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        getWeather()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let topPadding = navigationController?.navigationBar.frame.maxY {
            self.tableView.contentInset = UIEdgeInsets(top: topPadding, left: 0, bottom: 0, right: 0)
            self.tableView.scrollIndicatorInsets = UIEdgeInsets(top: topPadding, left: 0, bottom: 0, right: 0)
        }
    }

    func getWeather() {

        if basketballCourt != nil {
            let courtAddress = basketballCourt!.address
            let index = courtAddress.index(courtAddress.startIndex, offsetBy: 5)
            let town = courtAddress.substring(to: index)

            WeatherProvider.shared.getWeather(town: town, completion: { (weather, error) in

                if error == nil {
                    self.weather = weather
                    self.tableView.reloadData()
                } else {
                    print("Error in BasketballCourtDetailViewController - Get weather")
                }
            })
        } else {
            print("Error in BasketballCourtDetailViewController getWeather()")
        }
    }

    func setView() {

        setTableViewBackground(tableView: self.tableView,
                               imageName: Constant.BackgroundName.basketball)

        // 分隔線
        tableView.separatorStyle = .none

        let weatherNib = UINib(nibName: WeatherTableViewCell.identifier, bundle: nil)
        tableView.register(weatherNib, forCellReuseIdentifier: WeatherTableViewCell.identifier)

        let mapNib = UINib(nibName: MapTableViewCell.identifier, bundle: nil)
        tableView.register(mapNib, forCellReuseIdentifier: MapTableViewCell.identifier)

        let commentNib = UINib(nibName: CommentTableViewCell.identifier, bundle: nil)
        tableView.register(commentNib, forCellReuseIdentifier: CommentTableViewCell.identifier)

    }

    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {

        return components.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch components[section] {
        case .weather, .map, .comment:

            return 1
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast

        let component = components[indexPath.section]

        switch component {
        case .weather:

            let identifier = WeatherTableViewCell.identifier

            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! WeatherTableViewCell

            return setWeatherCell(cell: cell)

        case .map:

            let identifier = MapTableViewCell.identifier

            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MapTableViewCell

            return setMapCell(cell: cell)

        case .comment:

            let identifier = CommentTableViewCell.identifier

            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CommentTableViewCell

            return setCommentCell(cell: cell)
        }
        // swiftlint:enable force_cast
    }

    func setWeatherCell(cell: WeatherTableViewCell) -> WeatherTableViewCell {

        cell.selectionStyle = .none
        cell.layer.backgroundColor = UIColor.clear.cgColor

        if let desc = weather?.desc,
            let weatherPicName = weather?.weatherPicName,
            let temperature = weather?.temperature,
            let time = weather?.time {

            cell.weatherImage.image = UIImage(named: weatherPicName)
            cell.weatherLabel.text = "天氣 : \(desc)"
            cell.temperatureLabel.text = "氣溫 : \(temperature) 度"
            cell.updateTimeLabel.text = "更新時間 : \(time)"

        } else {

            cell.weatherImage.image = UIImage(named: Constant.ImageName.fixing)
            cell.weatherLabel.text = ""
            cell.temperatureLabel.text = "天氣即時資訊更新維護中..."
            cell.updateTimeLabel.text = ""
        }

        cell.weatherLabel.adjustsFontSizeToFitWidth = true
        cell.temperatureLabel.adjustsFontSizeToFitWidth = true
        cell.updateTimeLabel.adjustsFontSizeToFitWidth = true

        return cell
    }

    func setMapCell(cell: MapTableViewCell) -> MapTableViewCell {

        cell.selectionStyle = .none
        cell.layer.backgroundColor = UIColor.clear.cgColor

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
    }

    func setCommentCell(cell: CommentTableViewCell) -> CommentTableViewCell {

        cell.selectionStyle = .none
        cell.layer.backgroundColor = UIColor.clear.cgColor

        if let address = basketballCourt?.address,
            let tel = basketballCourt?.tel {

            cell.courtAddress.text = "地址 : \(address)"
            cell.courtTel.text = "電話 : \(tel)"

        } else {
            cell.courtAddress.text = "場地資料更新維護中..."
            cell.courtTel.text = ""
        }

        cell.courtAddress.adjustsFontSizeToFitWidth = true
        cell.courtTel.adjustsFontSizeToFitWidth = true

        return cell
    }

}
