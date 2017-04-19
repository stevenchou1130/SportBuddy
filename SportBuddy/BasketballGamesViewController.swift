//
//  BasketballGamesViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/4/13.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import Firebase
import BTNavigationDropdownMenu

class BasketballGamesViewController: BaseViewController {

    @IBOutlet weak var gamesTableView: UITableView!

    let loadingIndicator = LoadingIndicator()
    var menuView: BTNavigationDropdownMenu?

    var gamesList: [AnyObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getGames()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if menuView != nil {
            menuView?.hide()
        }
    }

    func setView() {

        setBackground(imageName: Constant.BackgroundName.basketball)

        setNavigationBar()
        setTableView()
    }

    func setTableView() {

        self.automaticallyAdjustsScrollViewInsets = false

        let nib = UINib(nibName: Constant.Cell.game, bundle: nil)
        gamesTableView.register(nib, forCellReuseIdentifier: Constant.Cell.game)

        // Separator
        // gamesTableView.separatorStyle = .none
    }

    func setNavigationBar() {

        transparentizeNavigationBar(navigationController: self.navigationController)

        let backButton = createBackButton(action: #selector(backToSportItemsView))
        self.navigationItem.leftBarButtonItem = backButton

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Button_New"), style: .done, target: self, action: #selector(createNewBasketballGameGame))

        setNavigationDropdownMenu()

        /*
        // todo: 看要不要調整 bar left button的位子
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.navigationItem.setLeftBarButtonItems([flexible, backButton, flexible, flexible], animated: false)
         */
    }

    func setNavigationDropdownMenu() {

        menuView = BTNavigationDropdownMenu(title: items[Constant.CurrentCity.cityIndex], items: items as [AnyObject])
        self.navigationItem.titleView = menuView

        menuView?.didSelectItemAtIndexHandler = { [weak self] (indexPath: Int) -> Void in

            if let city = self?.items[indexPath] {
                Constant.CurrentCity.cityIndex = indexPath
                Constant.CurrentCity.cityName = city
            }
        }

        menuView?.menuTitleColor = .white
        menuView?.cellTextLabelColor = .white
        menuView?.cellSelectionColor = .white
        menuView?.cellSeparatorColor = .white
        menuView?.cellBackgroundColor = .black
    }

    func getGames() {

        loadingIndicator.start()

        let ref = FIRDatabase.database().reference().child(Constant.FirebaseGame.nodeName)

        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            if snapshot.exists() {

                // todo: 顯示顯示所在城市的game
                // todo: 拉出來成一個game provider

                // todo: 過期的game要刪掉 ( 可以先不show在list上，用另個App刪除 ) -> done
                // todo: 將從firebase讀回來的資料，show在list上 -> done

                print("snapshot.exists()")

                if let snaps = snapshot.children.allObjects as? [FIRDataSnapshot] {
                    for snap in snaps {

                        // Don't show overtime games and add to list
                        if let gameInfo = snap.value as? NSDictionary,
                            let gameTime = gameInfo[Constant.FirebaseGame.time] as? String {

                            let formatter = DateFormatter()
                            formatter.dateFormat = "yyyy/MM/dd HH:mm"
                            formatter.locale = Locale.current

                            let currectTime = formatter.string(from: Date())

                            var isNotRepetition = true

                            for gameDate in self.gamesList {

                                guard
                                    let game = gameDate as? NSDictionary
                                    else { return }

                                // Judgement - Having same item or not
                                if game == gameInfo {
                                    isNotRepetition = false
                                }
                            }

                            if gameTime > currectTime && isNotRepetition {
                                self.gamesList.append(gameInfo)
                            }

                        } else {
                            print("== Parser is having question in BasketballGamesViewController01")
                        }
                    }

                    self.gamesTableView.reloadData()

                } else {
                    print("== Parser is having question in BasketballGamesViewController02")
                }

                self.loadingIndicator.stop()

            } else {
                print("snapshot does not exist")
                self.loadingIndicator.stop()
            }
        })
    }

//    func parserCourtInfo(_ gameCourt: NSDictionary) {
//
//        if let gameCourt = gameCourt[Constant.FirebaseGame.court] as? NSDictionary,
//            let gameMembers = gameCourt[Constant.FirebaseGame.members] as? NSArray,
//            let gameName = gameCourt[Constant.FirebaseGame.name] as? String,
//            let gameItem = gameCourt[Constant.FirebaseGame.itme] as? String,
//            let gameOwner = gameCourt[Constant.FirebaseGame.owner] as? String,
//            let gameTime = gameCourt[Constant.FirebaseGame.time] as? String,
//            let gameLevel = gameCourt[Constant.FirebaseGame.level] as? String {
//
//            print("==========")
//            print("gameName: \(gameName)")
//            print("gameLevel: \(gameLevel)")
//            print("gameCourt.count: \(gameCourt.count)")
//            print("gameMembers.count: \(gameMembers.count)")
//        }
//
//        var basketballCourt: BasketballCourt?
//
//        if let address = gameCourt[Constant.CourtInfo.address] as? String,
//            let name = gameCourt[Constant.CourtInfo.name] as? String,
//            let gymFuncList = gameCourt[Constant.CourtInfo.gymFuncList] as? String,
//            let courtID = gameCourt[Constant.CourtInfo.courtID] as? Int,
//            let latitude = gameCourt[Constant.CourtInfo.latitude] as? String,
//            let longitude = gameCourt[Constant.CourtInfo.longitude] as? String,
//            let tel = gameCourt[Constant.CourtInfo.tel] as? String?,
//            let rate = gameCourt[Constant.CourtInfo.rate] as? Int,
//            let rateCount = gameCourt[Constant.CourtInfo.rateCount] as? Int {
//
//            basketballCourt = BasketballCourt(courtID: courtID, name: name, tel: tel, address: address, rate: rate, rateCount: rateCount, gymFuncList: gymFuncList, latitude: latitude, longitude: longitude)
//        }
//
//        return basketballCourt
//    }

    func createNewBasketballGameGame() {
        let storyBoard = UIStoryboard(name: Constant.Storyboard.newBasketballGame, bundle: nil)
        guard let newBasketballGameViewController = storyBoard.instantiateViewController(withIdentifier: Constant.Controller.newBasketballGame) as? NewBasketballGameViewController else { return }

        self.navigationController?.pushViewController(newBasketballGameViewController, animated: true)
    }
}

// MARK: TableView
extension BasketballGamesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension

        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return gamesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Cell.game,
                                                     for: indexPath) as? GameTableViewCell
            else { return UITableViewCell() }

        cell.selectionStyle = .none
        cell.backgroundColor = .clear

        let gameInfo = gamesList[indexPath.row]

        if let gameCourt = gameInfo[Constant.FirebaseGame.court] as? NSDictionary,
            let gameMembers = gameInfo[Constant.FirebaseGame.members] as? NSArray,
            let gameName = gameInfo[Constant.FirebaseGame.name] as? String,
            let gameItem = gameInfo[Constant.FirebaseGame.itme] as? String,
            let gameOwner = gameInfo[Constant.FirebaseGame.owner] as? String,
            let gameTime = gameInfo[Constant.FirebaseGame.time] as? String,
            let gameLevel = gameInfo[Constant.FirebaseGame.level] as? String {

            if let courtName = gameCourt[Constant.CourtInfo.name] as? String {
                cell.location.text = courtName
            } else {
                print("== Can't parser court name")
            }

            cell.name.text = gameName
            cell.peopleNum.text = String(gameMembers.count)
            cell.time.text = gameTime

            switch gameLevel {

            case "A":
                cell.levelImage.image = #imageLiteral(resourceName: "Level_A")
            case "B":
                cell.levelImage.image = #imageLiteral(resourceName: "Level_B")
            case "C":
                cell.levelImage.image = #imageLiteral(resourceName: "Level_C")
            case "D":
                cell.levelImage.image = #imageLiteral(resourceName: "Level_D")
            case "E":
                cell.levelImage.image = #imageLiteral(resourceName: "Level_E")

            default:
                cell.levelImage.image = #imageLiteral(resourceName: "Level_C")
            }
        }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyBoard = UIStoryboard(name: Constant.Storyboard.basketballGameDetail, bundle: nil)

        guard
            let basketballGameDetailViewController = storyBoard.instantiateViewController(withIdentifier: Constant.Controller.basketballGameDetail) as? BasketballGameDetailViewController
            else { return }

        self.navigationController?.pushViewController(basketballGameDetailViewController, animated: true)
    }
}
