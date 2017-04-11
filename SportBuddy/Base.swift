//
//  Base.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/4/11.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView

class Base {

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

// MARK: NVActivityIndicatorView
extension BaseViewController {
    
    func setNVActivityIndicatorView() {
        
        NVActivityIndicatorView.DEFAULT_BLOCKER_SIZE = CGSize(width: 60, height: 60)
        NVActivityIndicatorView.DEFAULT_BLOCKER_BACKGROUND_COLOR = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
    }
}
