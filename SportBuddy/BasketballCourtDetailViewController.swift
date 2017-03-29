//
//  BasketballCourtDetailViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/27.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class BasketballCourtDetailViewController: UIViewController {

    enum Component {

        case weather, map, comment

    }

    // MARK: Property

    var components: [Component] = [ .weather, .map, .comment ]

    var navigationTitle: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = navigationTitle
    }
}
