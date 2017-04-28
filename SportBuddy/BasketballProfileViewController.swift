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

    var currentUserUID = ""
    var userInfo: User?

    let loadingIndicator = LoadingIndicator()

    var totalGameNum = 0
    var joinedGamesNum = 0
    var lastGameDate = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        setCurrentUID()
        setUser()
        setView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getUserJoinedGames()
    }

    func setCurrentUID() {

        guard
            let uid = FIRAuth.auth()?.currentUser?.uid
            else { return }

        self.currentUserUID = uid
    }

    func setUser() {

        UserManager.shared.getUserInfo(currentUserUID: currentUserUID) { (user, error) in

            if error == nil {
                self.userInfo = user
            } else {
                print("=== error in BasketballProfileViewController: \(String(describing: error))")
            }
        }
    }

    func setView() {

        setBackground(imageName: Constant.BackgroundName.basketball)

        setNavigationBar()
    }

    func setNavigationBar() {

        navigationItem.leftBarButtonItem = createBackButton(action: #selector(backToSportItemsView))
        transparentizeNavigationBar(navigationController: self.navigationController)
    }

    func getUserJoinedGames() {

        totalGameNum = 0
        joinedGamesNum = 0
        lastGameDate = ""

        let ref = FIRDatabase.database().reference()
                    .child(Constant.FirebaseUserGameList.nodeName)
                    .child(currentUserUID)

        // MARK: - Start Loading Indicator
        loadingIndicator.start()

        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            if snapshot.exists() {

                for gameID in ((snapshot.value as AnyObject).allKeys) {

                    guard
                        let gameIDString = gameID as? String
                        else { return }

                    let totalGames = (snapshot.value as AnyObject).allKeys.count

                    self.getUserHasDoneGamesInfo(gameIDString, totalGames)
                }
            } else {
                print("=== Can't find any date in BasketballProfileViewController - getUserJoinedGames()")
                self.loadingIndicator.stop()
            }
        })
    }

    func getUserHasDoneGamesInfo(_ gameIDString: String, _ totalGames: Int) {

        let parser = BasketballGameParser()

        let gameRef = FIRDatabase.database().reference()
            .child(Constant.FirebaseGame.nodeName)
            .child(gameIDString)

        gameRef.observeSingleEvent(of: .value, with: { (snap) in

            self.totalGameNum += 1

            if snap.exists() {
                let game = parser.parserGame(snap)

                guard game != nil else { return }

                let isOwnerInGame = self.checkOwnerInGame(game!)
                let isOverTime = self.checkGameTime(game!)

                // 1. Count how many games user had joined
                // 2. Get the date of last game
                if isOwnerInGame && isOverTime {
                    self.joinedGamesNum += 1
                    self.setLastGameTime(self.lastGameDate, game!)
                }

                // Set data to UI & firebase in final of  this loop
                if self.totalGameNum == totalGames {
                    DispatchQueue.main.async {
                        self.joinedGamesCount.text = String(self.joinedGamesNum)
                        if self.lastGameDate != "" {
                            self.lastGameTime.text = String(self.lastGameDate)
                        }
                    }
                    self.setUpgradeButton()
                    self.updateFireBaseDB()
                }
            } else {
                print("=== Can't find the game: \(snap.key) in BasketballProfileViewController")
            }
        })
    }

    func setUpgradeButton() {

        LevelManager.shared.checkLevelStatus(userID: currentUserUID, playedGamesCount: (userInfo?.playedGamesCount)!) { (isEnoughToUpgrade) in

            guard
                isEnoughToUpgrade != nil else { return }

            if isEnoughToUpgrade! {
                // todo: 按鈕變亮色 and 能按
                print("=== can press")
            } else {
                // todo: 按鈕變灰階 and 不能按
                print("=== can't press")
            }
        }
    }

    func updateFireBaseDB() {

        let ref = FIRDatabase.database().reference()
                    .child(Constant.FirebaseUser.nodeName)
                    .child(currentUserUID)

        let userUpdatedInfo: [String: Any] = [Constant.FirebaseUser.playedGamesCount: joinedGamesNum,
                                              Constant.FirebaseUser.lastTimePlayedGame: lastGameDate]

        ref.updateChildValues(userUpdatedInfo) { (error, _) in

            if error != nil {
                print("=== Error in BasketballProfileViewController: \(String(describing: error))")
            }

            // MARK: - Stop Loading Indicator
            self.loadingIndicator.stop()
        }

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
    func setLastGameTime(_ tempLastGameTime: String, _ game: BasketballGame) {

        var time = ""

        if tempLastGameTime > game.time {
            time = tempLastGameTime
        } else {
            time = game.time
        }

        // Remove hh:mm
        let splitedArray = time.characters.split { $0 == " " }.map(String.init)

        self.lastGameDate = splitedArray[0]
    }

    @IBAction func upgrade(_ sender: Any) {

        // todo: 完成多少場比賽，就可以Level up
        print("last game: \(String(describing: userInfo?.lastTimePlayedGame))")
        print("game times: \(String(describing: userInfo?.playedGamesCount))")

        LevelManager.shared.upgradeLevel()
    }

}
