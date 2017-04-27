//
//  BasketballGameDetailViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/4/14.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import MapKit
import Firebase

class BasketballGameDetailViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!

    enum Component {
        case weather, map, members, joinOrLeave
    }

    var components: [Component] = [ .weather, .map, .members, .joinOrLeave]

    var currentUserUid = ""
    var game: BasketballGame?
    var weather: Weather?
    var members: [User] = []

    var isUserInMembers = false
    var isTotallyUpdated = false

    let loadingIndicator = LoadingIndicator()
    let fullScreenSize = UIScreen.main.bounds.size

    override func viewDidLoad() {
        super.viewDidLoad()

        if let uid = FIRAuth.auth()?.currentUser?.uid {
            currentUserUid = uid
        } else {
            print("=== Can't find this user in BasketballGameDetailViewController")
        }

        setView()
        getWeather()
        getMembersInfo()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // MARK: Loading indicator
        self.loadingIndicator.start()

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

        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
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

            WeatherProvider.shared.getWeather(town: town, completion: { (weather, error) in

                if error == nil {
                    self.weather = weather
                    self.tableView.reloadData()
                } else {
                    print("=== Error in BasketballGameDetailViewController - Get weather")
                }
            })
        } else {
            print("=== Error in BasketballGameDetailViewController getWeather()")
        }
    }

    func getMembersInfo() {

        guard
            game != nil,
            game?.members.count != 0
            else { return }

        MemebersProvider.sharded.getMembers(gameID: (game?.gameID)!) { (members) in

            for member in members {
                let ref = FIRDatabase.database().reference().child(Constant.FirebaseUser.nodeName).child(member)

                ref.observeSingleEvent(of: .value, with: { (snapshot) in

                    if snapshot.exists() {

                        guard
                            let userData = snapshot.value as? [String: Any],
                            let name = userData[Constant.FirebaseUser.name] as? String,
                            let email = userData[Constant.FirebaseUser.email] as? String,
                            let gender = userData[Constant.FirebaseUser.gender] as? String,
                            let photoURL = userData[Constant.FirebaseUser.photoURL] as? String
                            else {
                                return
                        }

                        var lastTimePlayedGame = ""
                        var playedGamesCount = 0
                        
                        if let lastTime = userData[Constant.FirebaseUser.lastTimePlayedGame] as? String {
                            lastTimePlayedGame = lastTime
                        }
                        
                        if let gamesCount = userData[Constant.FirebaseUser.playedGamesCount] as? Int {
                            playedGamesCount = gamesCount
                        }
                        
                        let user = User(email: email, name: name, gender: gender, photoURL: photoURL,
                                        lastTimePlayedGame: lastTimePlayedGame, playedGamesCount: playedGamesCount)

                        self.members.append(user)

                        if member == members[members.count-1] {
                            self.tableView.reloadData()
                            self.loadingIndicator.stop()
                        }
                    } else {
                        print("=== Error: Can't find the user - \(member)")
                        self.loadingIndicator.stop()
                    }
                })
            }
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

            return JoinOrLeaveTableViewCell.height
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        // swiftlint:disable force_cast

        let component = components[indexPath.section]

        switch component {
        case .weather:

            let identifier = WeatherTableViewCell.identifier

            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! WeatherTableViewCell

            return setWeatherCell(cell)

        case .map:

            let identifier = MapTableViewCell.identifier

            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MapTableViewCell

            return setMapCell(cell)

        case .members:

            let identifier = MembersTableViewCell.identifier
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! MembersTableViewCell

            setCellBasicStyle(cell)

            cell.game = game
            cell.members = members
            cell.collectionView.reloadData()

            return cell

        case .joinOrLeave:

            let identifier = JoinOrLeaveTableViewCell.identifier

            let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! JoinOrLeaveTableViewCell

            return setJoinOrLeaveTableViewCell(cell)
        }

        // swiftlint:enable force_cast
    }

    func setJoinOrLeaveTableViewCell(_ cell: JoinOrLeaveTableViewCell) -> JoinOrLeaveTableViewCell {

        if currentUserUid != "" && game != nil {
            for member in (game?.members)! {

                if member == currentUserUid {
                    isUserInMembers = true
                }

                if isUserInMembers {
                    // show leave button
                    cell.joinButton.isHidden = true
                    cell.leaveButton.isHidden = false

                    cell.leaveButton.addTarget(self, action: #selector(leaveFromGame), for: .touchUpInside)

                } else {
                    // show join button
                    cell.leaveButton.isHidden = true
                    cell.joinButton.isHidden = false

                    cell.joinButton.addTarget(self, action: #selector(joinToGame), for: .touchUpInside)
                }
            }
        } else {
            print("=== Error: Someing is wrong in BasketballGameDetailViewController")
        }

        setCellBasicStyle(cell)

        return cell
    }

    func joinToGame() {

        guard
            game != nil else { return }

        if isUserInMembers {
            return
        }

        var newMemberList: [String] = []
        newMemberList = (game?.members)!
        newMemberList.append(currentUserUid)

        let value = [Constant.FirebaseGame.members: newMemberList]
        getGameDBRef().updateChildValues(value) { (error, _) in

            if error == nil {
                self.getMembersInfo()
                self.setUserGameList(isJoined: true)
                self.navigationController?.popViewController(animated: true)
            } else {
                print("=== Error in BasketballGameDetailViewController joinToGame()")
            }
        }
    }

    func leaveFromGame() {

        guard
            game != nil else { return }

        if !isUserInMembers {
            return
        }

        var newMemberList: [String] = []

        for member in (game?.members)! {
            if member != currentUserUid {
                newMemberList.append(member)
            }
        }

        let value = [Constant.FirebaseGame.members: newMemberList]
        getGameDBRef().updateChildValues(value) { (error, _) in

            if error == nil {
                self.getMembersInfo()
                self.setUserGameList(isJoined: false)
                self.navigationController?.popViewController(animated: true)
            } else {
                print("=== Error in BasketballGameDetailViewController joinToGame()")
            }
        }
    }

    func getGameDBRef() -> FIRDatabaseReference {

        let ref = FIRDatabase.database().reference().child(Constant.FirebaseGame.nodeName).child((game?.gameID)!)
        return ref
    }

    func setUserGameList(isJoined: Bool) {

        let ref = FIRDatabase.database().reference()
            .child(Constant.FirebaseUserGameList.nodeName)
            .child(currentUserUid)

        if isJoined {

            let value: [String: Int] = [(game?.gameID)!: 1]
            ref.updateChildValues(value) { (error, _) in

                if error != nil {
                    print("=== Error in BasketballGameDetailViewController setUserGameList() - join")
                }
            }
        } else {

            ref.child((game?.gameID)!).removeValue(completionBlock: { (error, _) in

                if error != nil {
                    print("=== Error in BasketballGameDetailViewController setUserGameList() - delete")
                }
            })
        }
    }

    func setWeatherCell(_ cell: WeatherTableViewCell) -> WeatherTableViewCell {

        setCellBasicStyle(cell)

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

    func setMapCell(_ cell: MapTableViewCell) -> MapTableViewCell {

        setCellBasicStyle(cell)

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

    func setCellBasicStyle(_ cell: UITableViewCell) {

        cell.selectionStyle = .none
        cell.backgroundColor = .clear
    }
}
