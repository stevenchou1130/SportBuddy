//
//  BaseViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/21.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import Firebase

class BaseViewController: UIViewController {

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

// MARK: - Hide Keyboard When Tapped Around
extension BaseViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(BaseViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - Show error alert
extension BaseViewController {

    func showErrorAlert(error: Error?, myErrorMsg: String?) {

        var errorMsg: String = ""

        if error != nil {
            errorMsg = (error?.localizedDescription)!
        } else if myErrorMsg != nil {
            errorMsg = myErrorMsg!
        }

        let alertController = UIAlertController(title: "Error Message", message: errorMsg, preferredStyle: .alert)

        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)

        self.present(alertController, animated: true, completion: nil)
    }
}
