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
import NVActivityIndicatorView

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let topPadding = navigationController?.navigationBar.frame.maxY {
            self.tableView.frame = CGRect(x: 0,
                                          y: topPadding,
                                          width: self.tableView.frame.width,
                                          height: self.tableView.frame.height)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.tabBarController?.tabBar.isHidden = false
    }

    func getWeather() {

        if basketballCourt != nil {
            let courtAddress = basketballCourt!.address
            let index = courtAddress.index(courtAddress.startIndex, offsetBy: 5)
            let town = courtAddress.substring(to: index)

            // MARK: Loading indicator
            let activityData = ActivityData()
            NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)

            WeatherProvider.shared.getWeather(town: town, completion: { (weather, error) in

                if error == nil {
                    self.weather = weather
                    self.tableView.reloadData()
                } else {
                    print("=== Error in BasketballCourtDetailViewController - Get weather")
                }

                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
            })
        } else {
            print("=== Error in BasketballCourtDetailViewController getWeather()")
        }
    }

    func setView() {

        // NavigationItem
        self.navigationItem.title = "球場資訊"

        // Background
        setBackground(imageName: Constant.BackgroundName.basketball)

        // Separator
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
        cell.backgroundColor = .clear

        if let desc = weather?.desc,
            let weatherPicName = weather?.weatherPicName,
            let temperature = weather?.temperature,
            let time = weather?.time {

            cell.weatherImage.image = UIImage(named: weatherPicName)
            cell.weatherLabel.text = "天氣 : \(desc)"
            cell.temperatureLabel.text = "氣溫 : \(temperature) 度"
            cell.updateTimeLabel.text = "更新時間 : \n \(time)"

        } else {

//            cell.weatherImage.image = UIImage(named: Constant.ImageName.fixing)
            cell.weatherLabel.text = ""
            cell.temperatureLabel.text = "天氣即時資訊更新維護中..."
            cell.updateTimeLabel.text = ""
        }

        return cell
    }

    func setMapCell(cell: MapTableViewCell) -> MapTableViewCell {

        cell.selectionStyle = .none
        cell.backgroundColor = .clear

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
        cell.backgroundColor = .clear

        if let name = basketballCourt?.name,
            let address = basketballCourt?.address,
            let tel = basketballCourt?.tel {

            cell.courtName.text = "\(name)"
            cell.courtAddress.text = "\(address)"
            cell.courtTel.text = "\(tel)"

        } else {
            cell.addressLabel.text = ""
            cell.courtLabel.text = ""
            cell.telLabel.text = ""
            cell.courtName.text = "場地資料更新維護中..."
            cell.courtAddress.text = ""
            cell.courtTel.text = ""
        }

        return cell
    }

}
