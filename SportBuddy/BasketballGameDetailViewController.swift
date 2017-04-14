//
//  BasketballGameDetailViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/4/14.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class BasketballGameDetailViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

//        if let topPadding = navigationController?.navigationBar.frame.maxY {
//            self.tableView.contentInset = UIEdgeInsets(top: topPadding, left: 0, bottom: 0, right: 0)
//            self.tableView.scrollIndicatorInsets = UIEdgeInsets(top: topPadding, left: 0, bottom: 0, right: 0)
//        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.tabBarController?.tabBar.isHidden = false
    }
}

extension BasketballGameDetailViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 30
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.darkGray

        return cell
    }

}
