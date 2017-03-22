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
