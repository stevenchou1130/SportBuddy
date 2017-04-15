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

        setView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.tabBarController?.tabBar.isHidden = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        if let topPadding = navigationController?.navigationBar.frame.maxY {
            self.tableView.frame = CGRect(x: 0,
                                          y: topPadding,
                                          width: self.tableView.frame.width,
                                          height: self.tableView.frame.height - topPadding)
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        self.tabBarController?.tabBar.isHidden = false
    }

    func setView() {

        setBackground(imageName: Constant.BackgroundName.basketball)

        // Separator
        tableView.separatorStyle = .none
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

        cell.selectionStyle = .none
        cell.backgroundColor = .clear

        return cell
    }

}
