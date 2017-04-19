//
//  BasketballGameDetailViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/4/14.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import MapKit

class BasketballGameDetailViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!

    enum Component {
        case weather, map, members, joinOrLeave
    }

    var components: [Component] = [ .weather, .map, .members, .joinOrLeave ]

    var game: BasketballGame?
    var weather: Weather?

    let loadingIndicator = LoadingIndicator()
    let fullScreenSize = UIScreen.main.bounds.size

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

    func setView() {
        // NavigationItem
        self.navigationItem.title = "球賽資訊"

        // Background
        setBackground(imageName: Constant.BackgroundName.basketball)

        // Separator
        tableView.separatorStyle = .none

        let weatherNib = UINib(nibName: WeatherTableViewCell.identifier, bundle: nil)
        tableView.register(weatherNib, forCellReuseIdentifier: WeatherTableViewCell.identifier)

        let mapNib = UINib(nibName: MapTableViewCell.identifier, bundle: nil)
        tableView.register(mapNib, forCellReuseIdentifier: MapTableViewCell.identifier)

        let membersNib = UINib(nibName: MembersTableViewCell.identifier, bundle: nil)
        tableView.register(membersNib, forCellReuseIdentifier: MembersTableViewCell.identifier)

        let joinOrLeaveNib = UINib(nibName: JoinOrLeaveTableViewCell.identifier, bundle: nil)
        tableView.register(joinOrLeaveNib, forCellReuseIdentifier: JoinOrLeaveTableViewCell.identifier)
    }

    func getWeather() {

        if game != nil {
            let courtAddress = game!.court.address
            let index = courtAddress.index(courtAddress.startIndex, offsetBy: 5)
            let town = courtAddress.substring(to: index)

            // MARK: Loading indicator
            self.loadingIndicator.start()

            WeatherProvider.shared.getWeather(town: town, completion: { (weather, error) in

                if error == nil {
                    self.weather = weather
                    self.tableView.reloadData()
                } else {
                    print("Error in BasketballGameDetailViewController - Get weather")
                }

                self.loadingIndicator.stop()
            })
        } else {
            print("Error in BasketballGameDetailViewController getWeather()")
        }
    }
}

extension BasketballGameDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {

        return components.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch components[section] {
        case .weather, .map, .members, .joinOrLeave:

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

        case .members:

            return MembersTableViewCell.height

        case .joinOrLeave:

            return 100
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

        case .members:

            let identifier = MembersTableViewCell.identifier

            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MembersTableViewCell

            cell.selectionStyle = .none
            cell.backgroundColor = .clear

            return cell

        case .joinOrLeave:

            let identifier = JoinOrLeaveTableViewCell.identifier

            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! JoinOrLeaveTableViewCell

//            let cell = UITableViewCell()
//            cell.frame = CGRect(x: 0.0, y: 0.0,
//                                width: fullScreenSize.width,
//                                height: fullScreenSize.height/5.0)

            cell.selectionStyle = .none
            cell.backgroundColor = .blue

            return cell
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

        if let latitudeString = game?.court.latitude,
            let longitudeString = game?.court.longitude {

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

}
