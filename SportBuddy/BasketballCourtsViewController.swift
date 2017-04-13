//
//  BasketballCourtsViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/4/13.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu
import NVActivityIndicatorView

class BasketballCourtsViewController: BaseViewController {

    @IBOutlet var courtsTableView: UITableView!

    var basketballCourts: [BasketballCourt] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()

        let nib = UINib(nibName: Constant.Cell.court, bundle: nil)
        courtsTableView.register(nib, forCellReuseIdentifier: Constant.Cell.court)

        setCourts()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.courtsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.courtsTableView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    }

    func setCourts() {

        // MARK: Loading indicator
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)

        BasketballCourtsProvider.shared.getApiData(city: Constant.CurrentCity.cityName, gymType: Constant.GymType.basketball) { (basketballCourts, error) in

            if error == nil {

                self.basketballCourts = basketballCourts!
                self.courtsTableView.reloadData()

            } else {

                // todo: error handling

            }

            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }

    }
}

// MARK: NavigationBar
extension BasketballCourtsViewController {

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

                self?.setCourts()
            }
        }
    }
}

// MARK: TableView
extension BasketballCourtsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        guard basketballCourts.count != 0 else { return 0 }
        return basketballCourts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constant.Cell.court,
                                                     for: indexPath) as? CourtTableViewCell,
            basketballCourts[indexPath.row].name != ""
            else { return UITableViewCell() }

        cell.courtName.text = basketballCourts[indexPath.row].name
        cell.courtName.adjustsFontSizeToFitWidth = true

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyBoard = UIStoryboard(name: Constant.Storyboard.basketballCourtDetail, bundle: nil)

        guard
            let basketballCourtDetailViewController = storyBoard.instantiateViewController(withIdentifier: Constant.Controller.basketballCourtDetail) as? BasketballCourtDetailViewController
            else { return }

        guard
            let cell = tableView.cellForRow(at: indexPath) as? CourtTableViewCell
            else { return }

        basketballCourtDetailViewController.basketballCourt = basketballCourts[indexPath.row]
        basketballCourtDetailViewController.navigationItem.title = cell.courtName.text!
        self.navigationController?.pushViewController(basketballCourtDetailViewController, animated: true)
    }
}
