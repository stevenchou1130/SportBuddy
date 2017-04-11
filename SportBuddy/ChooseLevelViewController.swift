//
//  ChooseLevelViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/23.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import Firebase

class ChooseLevelViewController: BaseViewController {

    private var level = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }

    @IBAction func selectLevelA(_ sender: Any) {
        saveLevel(level: "A")
        toMainPage()
    }

    @IBAction func selectLevelB(_ sender: Any) {
        saveLevel(level: "B")
        toMainPage()
    }

    @IBAction func selectLevelC(_ sender: Any) {
        saveLevel(level: "C")
        toMainPage()
    }

    @IBAction func selectLevelD(_ sender: Any) {
        saveLevel(level: "D")
        toMainPage()
    }

    @IBAction func selectLevelE(_ sender: Any) {
        saveLevel(level: "E")
        toMainPage()
    }

    func setView() {

        setBackground(imageName: Constant.BackgroundName.basketball)

    }

    func saveLevel(level: String) {

        guard
            let uid = FIRAuth.auth()?.currentUser?.uid
            else { return }

        let ref = FIRDatabase.database().reference()
                    .child(Constant.FirebaseLevel.nodeName)
                    .child(uid)

        let values = [Constant.FirebaseLevel.basketball: level]

        ref.updateChildValues(values) { (error, _) in
            print("Error: \(String(describing: error))")
        }
    }

    func toMainPage() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

            let basketballStorybard = UIStoryboard(name: Constant.Storyboard.basketball, bundle: nil)
            let basketballTabbarViewController = basketballStorybard.instantiateViewController(withIdentifier: Constant.Controller.basketballTabbar) as? BasketballTabbarViewController

            appDelegate.window?.rootViewController = basketballTabbarViewController
        }
    }

}
