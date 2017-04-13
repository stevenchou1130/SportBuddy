//
//  BasketballGamesTableViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/23.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu

class BasketballGamesTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()

    }

    func setNavigationBar() {

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "新增球賽", style: .done, target: self, action: #selector(createNewBasketballGameGame))

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

    func createNewBasketballGameGame() {
        let storyBoard = UIStoryboard(name: Constant.Storyboard.newBasketballGame, bundle: nil)
        guard let newBasketballGameViewController = storyBoard.instantiateViewController(withIdentifier: Constant.Controller.newBasketballGame) as? NewBasketballGameViewController else { return }

        self.navigationController?.pushViewController(newBasketballGameViewController, animated: true)
    }
}

// MARK: TableView
extension BasketballGamesTableViewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()

//        guard
//            let cell = UITableViewCell()
//            else { return UITableViewCell() }

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyBoard = UIStoryboard(name: Constant.Storyboard.basketballGameDetail, bundle: nil)

        guard
            let basketballGameDetailTableViewController = storyBoard.instantiateViewController(withIdentifier: Constant.Controller.basketballGameDetail) as? BasketballGameDetailTableViewController
            else { return }

//        guard
//            let cell = tableView.cellForRow(at: indexPath) as? CourtTableViewCell
//            else { return }

//        basketballCourtDetailTableViewController.basketballCourt = basketballCourts[indexPath.row]
//        basketballCourtDetailTableViewController.navigationItem.title = cell.courtName.text!
        self.navigationController?.pushViewController(basketballGameDetailTableViewController, animated: true)
    }
}
