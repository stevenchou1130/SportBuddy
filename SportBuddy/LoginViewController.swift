//
//  LoginViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/20.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import Firebase
import NVActivityIndicatorView
import Crashlytics

class LoginViewController: BaseViewController {

    @IBOutlet weak var emailTexfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var testButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()

//        setCrashlyticsButton()
//        testButton.isHidden = true

        setView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
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

    func setCrashlyticsButton() {
        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
        button.setTitle("Crash", for: [])
        button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(button)
    }

    @IBAction func crashButtonTapped(_ sender: AnyObject) {
        Crashlytics.sharedInstance().crash()
    }

    func setView() {

        setBackground(imageName: Constant.BackgroundName.login)
    }

    @IBAction func login(_ sender: Any) {

        let email = emailTexfield.text!
        let password = passwordTextfield.text!

        // MARK: Loading indicator
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)

        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (_, error) in

            if error != nil {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
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

        // MARK: Loading indicator
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)

        FIRAuth.auth()?.signIn(withEmail: "steven@gmail.com", password: "aaaaaa", completion: { (_, error) in

            if error != nil {
                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
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
