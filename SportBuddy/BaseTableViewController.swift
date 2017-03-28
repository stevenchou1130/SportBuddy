//
//  BaseTableViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/23.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import BTNavigationDropdownMenu

class BaseTableViewController: UITableViewController {

    let items = ["台北市", "新北市", "基隆市", "桃園市", "新竹市", "新竹縣", "苗栗縣", "台中市", "彰化縣", "南投縣", "雲林縣", "嘉義市", "嘉義縣", "台南市", "高雄市", "屏東縣", "宜蘭縣", "花蓮縣", "台東縣", "澎湖縣", "金門縣", "連江縣" ]

    func backToSportItemsView() {

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

            let sportItemsStorybard = UIStoryboard(name: Constant.Storyboard.sportItems, bundle: nil)
            let sportItemsViewController = sportItemsStorybard.instantiateViewController(withIdentifier: Constant.Controller.sportItems) as? SportItemsViewController

            appDelegate.window?.rootViewController = sportItemsViewController
        }
    }
}

extension BaseTableViewController {

    func createBackButton(action: Selector) -> UIBarButtonItem {

        let button = UIBarButtonItem(title: Constant.ObjectValue.NavigationBarBackItemTitle,
                                     style: .done,
                                     target: self,
                                     action: action)

        button.tintColor = UIColor.black

        return button
    }
}
