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
            print("=========")
            print(logoutError)
            print("=========")
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

    // todo: add another item button action
    @IBAction func toBasketballGameList(_ sender: Any) {

        guard let uid = FIRAuth.auth()?.currentUser?.uid else { return }
        let rootRef = FIRDatabase.database().reference()

        rootRef.child(Constant.FirebaseLevel.nodeName).child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            // todo: 加上Loading圖示

            if snapshot.exists() {

                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

                    let basketballStorybard = UIStoryboard(name: Constant.Storyboard.basketball, bundle: nil)
                    let basketballTabbarViewController = basketballStorybard.instantiateViewController(withIdentifier: Constant.Controller.basketballTabbar) as? BasketballTabbarViewController

                    appDelegate.window?.rootViewController = basketballTabbarViewController
                }

            } else {

                let dbUrl = Constant.Firebase.dbUrl
                let ref = FIRDatabase.database().reference(fromURL: dbUrl)

                let levelsReference = ref.child(Constant.FirebaseLevel.nodeName).child(uid)

                let value = [Constant.FirebaseLevel.basketball: "",
                             Constant.FirebaseLevel.baseball: "",
                             Constant.FirebaseLevel.jogging: ""]

                levelsReference.updateChildValues(value, withCompletionBlock: { (err, _) in

                    if err != nil {
                        self.showErrorAlert(error: err, myErrorMsg: nil)
                        return
                    }

                    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

                        let chooseLevelStorybard = UIStoryboard(name: Constant.Storyboard.chooseLevel, bundle: nil)
                        let chooseLevelViewController = chooseLevelStorybard.instantiateViewController(withIdentifier: Constant.Controller.chooseLevel) as? ChooseLevelViewController

                        appDelegate.window?.rootViewController = chooseLevelViewController
                    }
                })
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
