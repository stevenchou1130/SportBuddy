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

    @IBOutlet weak var gamesTableView: UITableView!

    var menuView: BTNavigationDropdownMenu?

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if menuView != nil {
            menuView?.hide()
        }
    }

    func setView() {

        setBackground(imageName: Constant.BackgroundName.basketball)

        setNavigationBar()
        setTableView()
    }

    func setTableView() {

        self.automaticallyAdjustsScrollViewInsets = false

        // Separator
        // gamesTableView.separatorStyle = .none
    }

    func setNavigationBar() {

        transparentizeNavigationBar(navigationController: self.navigationController)

        let backButton = createBackButton(action: #selector(backToSportItemsView))
        self.navigationItem.leftBarButtonItem = backButton

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Button_New"), style: .done, target: self, action: #selector(createNewBasketballGameGame))

        setNavigationDropdownMenu()

        /*
        // todo: 看要不要調整 bar left button的位子
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        self.navigationItem.setLeftBarButtonItems([flexible, backButton, flexible, flexible], animated: false)
         */
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

        menuView?.menuTitleColor = .white
        menuView?.cellTextLabelColor = .white
        menuView?.cellSelectionColor = .white
        menuView?.cellSeparatorColor = .white
        menuView?.cellBackgroundColor = .black
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

        cell.selectionStyle = .none
        cell.backgroundColor = .clear

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyBoard = UIStoryboard(name: Constant.Storyboard.basketballGameDetail, bundle: nil)

        guard
            let basketballGameDetailViewController = storyBoard.instantiateViewController(withIdentifier: Constant.Controller.basketballGameDetail) as? BasketballGameDetailViewController
            else { return }

        self.navigationController?.pushViewController(basketballGameDetailViewController, animated: true)
    }
}
