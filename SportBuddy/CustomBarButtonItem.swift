//
//  CustomBarButtonItem.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/24.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class CustomBarButtonItem: UIBarButtonItem {

    override init() {
        super.init()

        self.title = "Custome Back"
        print("Custome Back")
    }

    init(style: UIBarButtonItemStyle, target: Any?, action: Selector?) {
        super.init()

        self.title = "Back"

        self.style = style

        self.target = target as AnyObject?

        self.action = action
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
