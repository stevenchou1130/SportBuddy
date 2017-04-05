//
//  BaseViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/21.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    func backToSportItemsView() {

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

            let sportItemsStorybard = UIStoryboard(name: Constant.Storyboard.sportItems, bundle: nil)
            let sportItemsViewController = sportItemsStorybard.instantiateViewController(withIdentifier: Constant.Controller.sportItems) as? SportItemsViewController

            appDelegate.window?.rootViewController = sportItemsViewController
        }
    }
}

extension BaseViewController {

    func createBackButton(action: Selector) -> UIBarButtonItem {

        let button = UIBarButtonItem(title: Constant.ObjectValue.NavigationBarBackItemTitle,
                                     style: .done,
                                     target: self,
                                     action: action)

        button.tintColor = UIColor.black

        return button
    }
}
