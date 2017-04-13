//
//  BasketballGamesViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/4/13.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu

class BasketballGamesViewController: BaseViewController {

    var menuView: BTNavigationDropdownMenu?

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        hideNavigationBar()

        //        if let topConstraint = navigationController?.navigationBar.frame.maxY {
        //            gamesTableView.contentInset = UIEdgeInsets(top: topConstraint, left: 0, bottom: 0, right: 0)
        //            gamesTableView.scrollIndicatorInsets = UIEdgeInsets(top: topConstraint, left: 0, bottom: 0, right: 0)
        //        }

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if menuView != nil {
            menuView?.hide()
        }
    }

    func setNavigationBar() {

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "新增球賽", style: .done, target: self, action: #selector(createNewBasketballGameGame))

        navigationItem.leftBarButtonItem = createBackButton(action: #selector(backToSportItemsView))

        setNavigationDropdownMenu()
    }

    func hideNavigationBar() {

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }

    func setNavigationDropdownMenu() {

        menuView = BTNavigationDropdownMenu(title: items[Constant.CurrentCity.cityIndex], items: items as [AnyObject])
        self.navigationItem.titleView = menuView

        menuView?.didSelectItemAtIndexHandler = { [weak self] (indexPath: Int) -> Void in

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
extension BasketballGamesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 30
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell()
        cell.backgroundColor = UIColor.darkGray

        //        guard
        //            let cell = UITableViewCell()
        //            else { return UITableViewCell() }

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

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
