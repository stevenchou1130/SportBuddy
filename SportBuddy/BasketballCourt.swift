//
//  BasketballCourts.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/27.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import Foundation

struct BasketballCourt: BasketballCourtModel {

    var courtID: Int
    var name: String
    var tel: String?
    var address: String
    var rate: Int
    var rateCount: Int
    var gymFuncList: String
    var latlng: String

    init(courtID: Int, name: String, tel: String?, address: String,
         rate: Int, rateCount: Int, gymFuncList: String, latlng: String) {

        self.courtID = courtID
        self.name = name
        self.tel = tel
        self.address = address
        self.rate = rate
        self.rateCount = rateCount
        self.gymFuncList = gymFuncList
        self.latlng = latlng
    }
}
