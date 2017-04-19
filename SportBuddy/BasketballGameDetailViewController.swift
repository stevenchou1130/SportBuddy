//
//  BasketballGameDetailViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/4/14.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class BasketballGameDetailViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!

    var gameInfo: AnyObject?

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()

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
                                          height: self.tableView.frame.height - topPadding)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.tabBarController?.tabBar.isHidden = false
    }

    func setView() {

        setBackground(imageName: Constant.BackgroundName.basketball)

        // Separator
        tableView.separatorStyle = .none
    }
}

extension BasketballGameDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 30
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()

        cell.selectionStyle = .none
        cell.backgroundColor = .clear

        return cell
    }

}
