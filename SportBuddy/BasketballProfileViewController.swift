//
//  BasketballProfileViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/23.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class BasketballProfileViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = createBackButton(action: #selector(backToSportItemsView))
    }

}
