//
//  Constant.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/20.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import Foundation

struct Constant {

    struct AppName {

        static let appName = NSLocalizedString("SportBuddy", comment: "")
    }

    struct Storyboard {

        static let login = "Login"
        static let signUp = "SignUp"
        static let sportItems = "SportItems"
        static let chooseLevel = "ChooseLevel"
        static let basketball = "Basketball"
    }

    struct Controller {

        static let login = "LoginViewController"
        static let signUp = "SignUpViewController"
        static let sportItems = "SportItemsViewController"
        static let chooseLevel = "ChooseLevelViewController"
        static let basketballTabbar = "BasketballTabbarViewController"
        static let basketballGames = "BasketballGamesTableViewController"
        static let basketballCourt = "BasketballCourtsTableViewController"
        static let basketballProfile = "BasketballProfileViewController"
    }

    struct Cell {

        static let basketballCourt = "BasketballCourtsTableViewCell"
    }

    struct CourtAPIKey {

        static let courtID = "GymID"
        static let name = "Name"
        static let tel = "OperationTel"
        static let address = "Address"
        static let rate = "Rate"
        static let rateCount = "RateCount"
        static let gymFuncList = "GymFuncList"
        static let latlng = "LatLng"
    }

    struct ObjectValue {

        static let NavigationBarBackItemTitle = "Sport Items"
    }
}
