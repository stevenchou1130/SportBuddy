//
//  BasketballGameDetailTableViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/4/12.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class BasketballGameDetailTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 30
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.darkGray

        return cell
    }
}
