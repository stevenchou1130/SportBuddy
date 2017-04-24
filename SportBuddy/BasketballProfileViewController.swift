//
//  BasketballProfileViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/23.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import Firebase

class BasketballProfileViewController: BaseViewController {

    @IBOutlet weak var joinedGamesCount: UILabel!
    @IBOutlet weak var lastGameTime: UILabel!
    @IBOutlet weak var upgradeButton: UIButton!

    let loadingIndicator = LoadingIndicator()

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getUserInfo()

    }

    func setView() {

        upgradeButton.isHidden = true

        setBackground(imageName: Constant.BackgroundName.basketball)

        setNavigationBar()

    }

    func getUserInfo() {

        guard
            let uid = FIRAuth.auth()?.currentUser?.uid
            else { return }

        let ref = FIRDatabase.database().reference()
                    .child(Constant.FirebaseUserGameList.nodeName)
                    .child(uid)

        let parser = BasketballGameParser()

        var totalGameNum = 0
        var doneGameNum = 0
        var lastGameDate = ""

        loadingIndicator.start()

        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            if snapshot.exists() {

                for gameID in ((snapshot.value as AnyObject).allKeys) {

                    guard
                        let gameIDString = gameID as? String
                        else { return }

                    let gameRef = FIRDatabase.database().reference()
                                    .child(Constant.FirebaseGame.nodeName)
                                    .child(gameIDString)

                    gameRef.observeSingleEvent(of: .value, with: { (snap) in

                        if snap.exists() {
                            let game = parser.parserGame(snap)

                            guard game != nil else { return }

                            totalGameNum += 1

                            let isOwnerInGame = self.checkOwnerInGame(game!)
                            let isOverTime = self.checkGameTime(game!)

                            if isOwnerInGame && isOverTime {
                                doneGameNum += 1
                                lastGameDate = self.checkLastGameTime(lastGameDate, game!)
                                // todo: 增加user 完成game次數 to firebase
                            }

                            if totalGameNum == (snapshot.value as AnyObject).allKeys.count {
                                DispatchQueue.main.async {
                                    self.joinedGamesCount.text = String(doneGameNum)
                                    self.lastGameTime.text = String(lastGameDate)
                                    self.loadingIndicator.stop()
                                }
                            }
                        } else {
                            print("=== Can't find the game in BasketballProfileViewController")
                        }
                    })
                }
            } else {
                print("=== Can't find any date in BasketballProfileViewController - getUserInfo()")
            }

        })
    }

    // MARK: - Check Owner in game
    func checkOwnerInGame(_ game: BasketballGame) -> Bool {

        var isOwnerInGame = true

        let owner = game.members.filter({ (member) -> Bool in
            member == game.owner
        })

        if owner.count == 0 {
            isOwnerInGame = false
        }

        return isOwnerInGame
    }

    // MARK: - Check game time
    func checkGameTime(_ game: BasketballGame) -> Bool {

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd HH:mm"
        formatter.locale = Locale.current

        let currectTime = formatter.string(from: Date())

        return currectTime > game.time
    }

    // MARK: - Check last game time
    func checkLastGameTime(_ tempLastGameTime: String, _ game: BasketballGame) -> String {

        var time = ""

        if tempLastGameTime > game.time {
            time = tempLastGameTime
        } else {
            time = game.time
        }

        let splitedArray = time.characters.split { $0 == " " }.map(String.init)

        return splitedArray[0]
    }

    func setNavigationBar() {

        navigationItem.leftBarButtonItem = createBackButton(action: #selector(backToSportItemsView))

        transparentizeNavigationBar(navigationController: self.navigationController)
    }

    @IBAction func upgrade(_ sender: Any) {
        print(" === upgrade ===")

        // todo: 完成多少場比賽，就可以Level up
    }
}
