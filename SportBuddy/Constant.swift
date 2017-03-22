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
    }

    struct Controller {
        static let login = "LoginViewController"
        static let signUp = "SignUpViewController"
        static let sportItems = "SportItemsViewController"
    }

}
