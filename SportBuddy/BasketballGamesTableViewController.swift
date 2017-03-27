//
//  BasketballGamesTableViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/23.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

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

    func createNewBasketballGameGame() {
        let storyBoard = UIStoryboard(name: Constant.Storyboard.newBasketballGame, bundle: nil)
        guard let newBasketballGameViewController = storyBoard.instantiateViewController(withIdentifier: Constant.Controller.newBasketballGame) as? NewBasketballGameViewController else { return }

        self.navigationController?.pushViewController(newBasketballGameViewController, animated: true)
    }

}
