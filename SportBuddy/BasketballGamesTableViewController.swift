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

        navigationItem.leftBarButtonItem = self.createBackButton(action: #selector(self.onClcikBack))

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    func onClcikBack() {
        print("=== Go back ===")

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

            let sportItemsStorybard = UIStoryboard(name: Constant.Storyboard.sportItems, bundle: nil)
            let sportItemsViewController = sportItemsStorybard.instantiateViewController(withIdentifier: Constant.Controller.sportItems) as? SportItemsViewController

            appDelegate.window?.rootViewController = sportItemsViewController
        }
    }
}

extension UIViewController {

    func createBackButton(action: Selector) -> UIBarButtonItem {

        let button = UIBarButtonItem(title: "Back",
                                     style: .done,
                                     target: self,
                                     action: action)

        button.tintColor = UIColor.black

        return button
    }
}
