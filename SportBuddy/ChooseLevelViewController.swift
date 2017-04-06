//
//  ChooseLevelViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/23.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class ChooseLevelViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // todo: 選等級之後，塞值到Firebase（包含其他運動項目的Level，先做三個）
    }

    @IBAction func selectLevelA(_ sender: Any) {
        toMainPage()
    }

    @IBAction func selectLevelB(_ sender: Any) {
    }

    @IBAction func selectLevelC(_ sender: Any) {
    }

    @IBAction func selectLevelD(_ sender: Any) {
    }

    @IBAction func selectLevelE(_ sender: Any) {
    }

    @IBAction func selectLevelF(_ sender: Any) {
    }

    func saveLevel() {}

    func toMainPage() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

            let basketballStorybard = UIStoryboard(name: Constant.Storyboard.basketball, bundle: nil)
            let basketballTabbarViewController = basketballStorybard.instantiateViewController(withIdentifier: Constant.Controller.basketballTabbar) as? BasketballTabbarViewController

            appDelegate.window?.rootViewController = basketballTabbarViewController
        }
    }

}
