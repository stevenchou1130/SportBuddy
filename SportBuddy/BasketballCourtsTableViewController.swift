//
//  BasketballCourtsTableViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/23.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class BasketballCourtsTableViewController: BaseTableViewController {

    @IBOutlet var courtsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = CustomBarButtonItem()

        let nib = UINib(nibName: Constant.Cell.basketballCourt, bundle: nil)

        courtsTableView.register(nib, forCellReuseIdentifier: Constant.Cell.basketballCourt)
        courtsTableView.delegate = self
        courtsTableView.dataSource = self
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Cell.basketballCourt, for: indexPath) as? BasketballCourtsTableViewCell
        else {
            return UITableViewCell()
        }

        return cell
    }

}
