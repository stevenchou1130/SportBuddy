//
//  BasketballGame.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/4/13.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import Foundation

struct BasketballGame {

    var owner: String
    var item: String
    var name: String
    var time: String
    var court: BasketballCourt
    var level: String
    var members: String?

    init(owner: String, item: String,
         name: String, time: String,
         court: BasketballCourt, level: String,
         members: String) {

        self.owner = owner
        self.item = item
        self.name = name
        self.time = time
        self.court = court
        self.level = level
        self.members = members
    }
}
