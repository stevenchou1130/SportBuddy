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

    let items = ["臺北市", "新北市", "基隆市", "桃園市", "新竹市", "新竹縣", "苗栗縣", "臺中市", "彰化縣", "南投縣", "雲林縣", "嘉義市", "嘉義縣", "臺南市", "高雄市", "屏東縣", "宜蘭縣", "花蓮縣", "臺東縣", "澎湖縣", "金門縣" ]

    func backToSportItemsView() {

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

            let sportItemsStorybard = UIStoryboard(name: Constant.Storyboard.sportItems, bundle: nil)
            let sportItemsViewController = sportItemsStorybard.instantiateViewController(withIdentifier: Constant.Controller.sportItems) as? SportItemsViewController

            appDelegate.window?.rootViewController = sportItemsViewController
        }
    }

    func setBackground(imageName: String) {

        let backgroundImage = UIImageView(frame: self.view.bounds)
        backgroundImage.image = UIImage(named: imageName)
        self.view.insertSubview(backgroundImage, at: 0)
    }
}

// MARK: - Navigation Bar Back Button
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

// MARK: - Hide Keyboard When Tapped Around
extension BaseTableViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseTableViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    func dismissKeyboard() {
        view.endEditing(true)

    }
}
