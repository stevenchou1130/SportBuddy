//
//  LoginViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/20.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: BaseViewController {

    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var accountTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }

    // todo: confirm use it or not.
    func isUsersignedin() {

        FIRAuth.auth()?.addStateDidChangeListener { _, user in
            if user != nil {
                // User is signed in.
                print("=== User is signed in ===")
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    let sportItemsStorybard = UIStoryboard(name: Constant.Storyboard.sportItems, bundle: nil)
                    let sportItemsViewController = sportItemsStorybard.instantiateViewController(withIdentifier: Constant.Controller.sportItems) as? SportItemsViewController

                    appDelegate.window?.rootViewController = sportItemsViewController
                }
            } else {
                // No user is signed in.
                print("=== No user sign in ===")
            }
        }
    }

    func setView() {

        setBackground(imageName: Constant.BackgroundName.basketball)

        appNameLabel.text = Constant.AppName.appName
    }

    @IBAction func login(_ sender: Any) {

        let account = accountTextfield.text!
        let password = passwordTextfield.text!

        FIRAuth.auth()?.signIn(withEmail: account, password: password, completion: { (_, error) in

            if error != nil {
                self.showErrorAlert(error: error, myErrorMsg: nil)
                return
            }

            // successfully login
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

                let sportItemsStorybard = UIStoryboard(name: Constant.Storyboard.sportItems, bundle: nil)
                let sportItemsViewController = sportItemsStorybard.instantiateViewController(withIdentifier: Constant.Controller.sportItems) as? SportItemsViewController

                appDelegate.window?.rootViewController = sportItemsViewController
            }
        })
    }

    @IBAction func signUp(_ sender: Any) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

            let signUpStorybard = UIStoryboard(name: Constant.Storyboard.signUp, bundle: nil)
            let signUpViewController = signUpStorybard.instantiateViewController(withIdentifier: Constant.Controller.signUp) as? SignUpViewController

            appDelegate.window?.rootViewController = signUpViewController
        }
    }

    /*
     *  For testing
     */
    @IBAction func testLogin(_ sender: Any) {
        FIRAuth.auth()?.signIn(withEmail: "aaa@gmail.com", password: "aaaaaa", completion: { (_, error) in

            if error != nil {
                self.showErrorAlert(error: error, myErrorMsg: nil)
                return
            }

            // successfully login
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

                let sportItemsStorybard = UIStoryboard(name: Constant.Storyboard.sportItems, bundle: nil)
                let sportItemsViewController = sportItemsStorybard.instantiateViewController(withIdentifier: Constant.Controller.sportItems) as? SportItemsViewController

                appDelegate.window?.rootViewController = sportItemsViewController
            }
        })
    }

}
