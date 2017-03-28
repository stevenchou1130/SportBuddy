//
//  BasketballCourtsTableViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/23.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu

class BasketballCourtsTableViewController: BaseTableViewController {

    @IBOutlet var courtsTableView: UITableView!

    var basketballCourts: [BasketballCourt] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()

        let nib = UINib(nibName: Constant.Cell.basketballCourt, bundle: nil)
        courtsTableView.register(nib, forCellReuseIdentifier: Constant.Cell.basketballCourt)
        courtsTableView.delegate = self
        courtsTableView.dataSource = self

        setCourts()
    }

    func setCourts() {

        BasketballCourtsManager.shared.getApiData(city: "新北市", gymType: Constant.GymType.basketball) { (basketballCourts, error) in

            if error == nil {

                // todo: 沒資料的縣市，要自己設假資料

                self.basketballCourts = basketballCourts!
                self.tableView.reloadData()

            } else {

                // todo: error handling

            }
        }
    }

    // For testing
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

    func setNavigationBar() {

        navigationItem.leftBarButtonItem = createBackButton(action: #selector(backToSportItemsView))
        setNavigationDropdownMenu()
    }

    func setNavigationDropdownMenu() {
        let menuView = BTNavigationDropdownMenu(title: items[Constant.CurrentCity.cityIndex], items: items as [AnyObject])
        self.navigationItem.titleView = menuView

        menuView.didSelectItemAtIndexHandler = { [weak self] (indexPath: Int) -> Void in

            if let city = self?.items[indexPath] {
                Constant.CurrentCity.cityIndex = indexPath
                Constant.CurrentCity.cityName = city
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard basketballCourts.count != 0 else { return 0 }
        return basketballCourts.count
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
        cell.courtName.adjustsFontSizeToFitWidth = true

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        // todo: set data to BasketballCourtDetail page

        let storyBoard = UIStoryboard(name: Constant.Storyboard.basketballCourtDetail, bundle: nil)
        guard let basketballCourtDetailViewController = storyBoard.instantiateViewController(withIdentifier: Constant.Controller.basketballCourtDetail) as? BasketballCourtDetailViewController else { return }

        guard let cell = tableView.cellForRow(at: indexPath) as? BasketballCourtsTableViewCell else { return }

        basketballCourtDetailViewController.navigationTitle = cell.courtName.text!

        self.navigationController?.pushViewController(basketballCourtDetailViewController, animated: true)
    }

}
