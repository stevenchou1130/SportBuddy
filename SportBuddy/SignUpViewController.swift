//
//  SignUpViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/21.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit

class SignUpViewController: BaseViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var accountTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }

    func setView() {
        userImage.layer.cornerRadius = userImage.bounds.size.width / 2.0
        userImage.layer.borderWidth = 1.0
    }

    @IBAction func signUp(_ sender: Any) {
        print("Sign up in SignUp page")
    }

    @IBAction func toLogin(_ sender: Any) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            appDelegate.window?.rootViewController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        }
    }
}
