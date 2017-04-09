//
//  SportItemsViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/23.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SportItemsViewController: BaseViewController {

    @IBOutlet weak var userImage: UIImageView!

    var isfirstTime = true

    override func viewDidLoad() {
        super.viewDidLoad()
        print("== SportItemsViewController ==")

        checkIfUserIsLoggedIn()
        setView()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        userImage.layer.cornerRadius = userImage.bounds.size.height / 2.0
        userImage.layer.borderWidth = 1.0
        userImage.layer.masksToBounds = true
    }

    func setView() {

        setBackground(imageName: Constant.BackgroundName.basketball)

        // todo: 滑動選單

    }

    func checkIfUserIsLoggedIn() {
        if FIRAuth.auth()?.currentUser?.uid == nil {
            handleLogout()
        }
    }

    func handleLogout() {

        do {
            try FIRAuth.auth()?.signOut()
        } catch let logoutError {
            print(logoutError)
        }

        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

            let loginStorybard = UIStoryboard(name: Constant.Storyboard.login, bundle: nil)
            let loginViewController = loginStorybard.instantiateViewController(withIdentifier: Constant.Controller.login) as? LoginViewController

            appDelegate.window?.rootViewController = loginViewController
        }
    }

    // todo: toEditProfile
    @IBAction func toEditProfile(_ sender: Any) {
    }

    @IBAction func toGameList(_ sender: Any) {

        // todo: add the judgment of sport item

        let rootRef = FIRDatabase.database().reference()
        rootRef.child("levels").queryOrdered(byChild: "host").queryEqual(toValue: FIRAuth.auth()?.currentUser?.uid).observeSingleEvent(of: .value, with: { (snapshot) in

            print("================")
            print("snapshot.exists(): \(snapshot.exists())")
            print("================")

            // todo: 加上Loading圖示

            if snapshot.exists() {
                // todo: 跳到主頁面
            } else {
                // todo: 判斷所選的運動，有無等級存在

                // todo: 跳到等級選單
            }

            if self.isfirstTime {
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
        })
    }

    /*
     *  For testing
     */
    @IBAction func logout(_ sender: Any) {

        if FIRAuth.auth()?.currentUser?.uid != nil {
            handleLogout()
        }
    }

}
