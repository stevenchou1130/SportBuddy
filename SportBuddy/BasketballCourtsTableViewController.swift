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

    var basketballCourts: [BasketballCourt] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = createBackButton(action: #selector(backToSportItemsView))

        let nib = UINib(nibName: Constant.Cell.basketballCourt, bundle: nil)
        courtsTableView.register(nib, forCellReuseIdentifier: Constant.Cell.basketballCourt)
        courtsTableView.delegate = self
        courtsTableView.dataSource = self

        createFakeCourts()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        courtsTableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if basketballCourts.count == 0 {
            return 20
        } else {
            return basketballCourts.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Cell.basketballCourt,
                                                     for: indexPath) as? BasketballCourtsTableViewCell,
            basketballCourts[indexPath.row].name != ""
        else {
            return UITableViewCell()
        }

        cell.courtName.text = basketballCourts[indexPath.row].name

        return cell
    }

    func createFakeCourts() {

        var fakeFakeCourts: [BasketballCourt] = []
        var fakeID = 1110

        for index in 1...30 {
            let fakeFakeCourt = BasketballCourt(courtID: fakeID, name: "Test\(index)", tel: "022722", address: "Taipei", rate: 3, rateCount: 2, gymFuncList: "籃球場", latlng: "25.1,121")

            fakeFakeCourts.append(fakeFakeCourt)

            fakeID += 1
        }

        self.basketballCourts = fakeFakeCourts
    }

}
