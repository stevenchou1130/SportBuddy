//
//  SportItemsViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/23.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class SportItemsViewController: BaseViewController {

    @IBOutlet weak var userImage: UIImageView!

    var isfirstTime = true

    override func viewDidLoad() {
        super.viewDidLoad()
        print("== SportItemsViewController ==")

        setView()
    }

    func setView() {
        userImage.layer.cornerRadius = userImage.bounds.size.width / 2.0
        userImage.layer.borderWidth = 1.0
    }

    @IBAction func toEditProfile(_ sender: Any) {
    }

    @IBAction func toGameList(_ sender: Any) {
        // Need adjust - add the judgment of sport item

        if isfirstTime {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

                let chooseLevelStorybard = UIStoryboard(name: Constant.Storyboard.chooseLevel, bundle: nil)
                let chooseLevelViewController = chooseLevelStorybard.instantiateViewController(withIdentifier: Constant.Controller.chooseLevel) as? ChooseLevelViewController

                appDelegate.window?.rootViewController = chooseLevelViewController
            }
        } else {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

                let basketballStorybard = UIStoryboard(name: Constant.Storyboard.basketball, bundle: nil)
                let basketballTabbarViewController = basketballStorybard.instantiateViewController(withIdentifier: Constant.Controller.basketballTabbar) as? BasketballTabbarViewController

                appDelegate.window?.rootViewController = basketballTabbarViewController
            }
        }

    }

    /*
     *  For testing
     */
    @IBAction func backLogin(_ sender: Any) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

            let loginStorybard = UIStoryboard(name: Constant.Storyboard.login, bundle: nil)
            let loginViewController = loginStorybard.instantiateViewController(withIdentifier: Constant.Controller.login) as? LoginViewController

            appDelegate.window?.rootViewController = loginViewController
        }
    }

}
