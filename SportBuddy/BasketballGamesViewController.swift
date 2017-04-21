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

    var gamesList: [BasketballGame] = []

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

                if let snaps = snapshot.children.allObjects as? [FIRDataSnapshot] {
                    for snap in snaps {

                        // Don't show overtime games and add to list
                        let gameParser = BasketballGameParser()

                        guard
                            let game = gameParser.parserGame(snap)
                            else { return }

                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy/MM/dd HH:mm"
                        formatter.locale = Locale.current

                        let currectTime = formatter.string(from: Date())

                        var isNotRepetition = true

                        for gameData in self.gamesList {

                            // Judgement - Having same item or not
                            if gameData.court.name == game.court.name &&
                                gameData.name == game.name &&
                                gameData.owner == game.owner &&
                                gameData.time == game.time {
                                isNotRepetition = false
                            }
                        }

                        if game.time > currectTime && isNotRepetition {
                            self.gamesList.append(game)
                        }
                    }

                    self.gamesTableView.reloadData()

                } else {
                    print("== Parser is having question in BasketballGamesViewController")
                }

                self.loadingIndicator.stop()

            } else {
                print("snapshot does not exist")
                self.loadingIndicator.stop()
            }
        })
    }

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

        let game = gamesList[indexPath.row]

        cell.location.text = game.court.name
        cell.name.text = game.name
        cell.peopleNum.text = String(game.members.count)
        cell.time.text = game.time

        switch game.level {

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

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyBoard = UIStoryboard(name: Constant.Storyboard.basketballGameDetail, bundle: nil)

        guard
            let basketballGameDetailViewController = storyBoard.instantiateViewController(withIdentifier: Constant.Controller.basketballGameDetail) as? BasketballGameDetailViewController
            else { return }

        basketballGameDetailViewController.game = gamesList[indexPath.row]

        self.navigationController?.pushViewController(basketballGameDetailViewController, animated: true)
    }
}
