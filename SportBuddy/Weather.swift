//
//  Weather.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/31.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import Foundation

struct Weather {

    var desc: String            // 天氣敘述
    var temperature: String     // 溫度
    var time: String            // 更新時間

    init(desc: String, temperature: String, time: String) {
        self.desc = desc
        self.temperature = temperature
        self.time = time
    }
}
