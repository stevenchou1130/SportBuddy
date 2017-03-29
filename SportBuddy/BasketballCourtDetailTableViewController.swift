//
//  BasketballCourtDetailTableViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/29.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class BasketballCourtDetailTableViewController: BaseTableViewController {

    enum Component {

        case weather, map, comment

    }

    // MARK: Property

    var components: [Component] = [ .weather, .map, .comment ]

    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
    }

    func setUp() {

        tableView.separatorStyle = .none
        tableView.register(
            WeatherTableViewCell.self,
            forCellReuseIdentifier: WeatherTableViewCell.identifier
        )
        tableView.register(
            MapTableViewCell.self,
            forCellReuseIdentifier: MapTableViewCell.identifier
        )
        tableView.register(
            CommentTableViewCell.self,
            forCellReuseIdentifier: CommentTableViewCell.identifier
        )

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

}
