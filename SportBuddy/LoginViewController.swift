//
//  LoginViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/20.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {

    @IBOutlet weak var appNameLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }

    func setView() {
        appNameLabel.text = Constant.AppName.appName
    }

    @IBAction func login(_ sender: Any) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

            let sportItemsStorybard = UIStoryboard(name: Constant.Storyboard.sportItems, bundle: nil)
            let sportItemsViewController = sportItemsStorybard.instantiateViewController(withIdentifier: Constant.Controller.sportItems) as? SportItemsViewController

            appDelegate.window?.rootViewController = sportItemsViewController
        }
    }

    @IBAction func signUp(_ sender: Any) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

            let signUpStorybard = UIStoryboard(name: Constant.Storyboard.signUp, bundle: nil)
            let signUpViewController = signUpStorybard.instantiateViewController(withIdentifier: Constant.Controller.signUp) as? SignUpViewController

            appDelegate.window?.rootViewController = signUpViewController
        }
    }
}
