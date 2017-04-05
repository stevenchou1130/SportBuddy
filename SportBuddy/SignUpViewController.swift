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
    @IBOutlet weak var genderLabel: UILabel!

    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!

    var maleRadioButton = LTHRadioButton()
    var femaleRadioButton = LTHRadioButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        maleRadioButton = LTHRadioButton(selectedColor: .blue)
        femaleRadioButton = LTHRadioButton(selectedColor: .blue)

        setView()
    }

    func setView() {
        userImage.layer.cornerRadius = userImage.bounds.size.width / 2.0
        userImage.layer.borderWidth = 1.0

        // Male Radio Button
        view.addSubview(maleRadioButton)
        maleRadioButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            maleRadioButton.centerYAnchor.constraint(equalTo: maleButton.centerYAnchor),
            maleRadioButton.trailingAnchor.constraint(equalTo: maleButton.leadingAnchor, constant: -10),
            maleRadioButton.heightAnchor.constraint(equalToConstant: maleRadioButton.frame.height),
            maleRadioButton.widthAnchor.constraint(equalToConstant: maleRadioButton.frame.width)])

        // Female Radio Button
        view.addSubview(femaleRadioButton)
        femaleRadioButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            femaleRadioButton.centerYAnchor.constraint(equalTo: femaleButton.centerYAnchor),
            femaleRadioButton.trailingAnchor.constraint(equalTo: femaleButton.leadingAnchor, constant: -10),
            femaleRadioButton.heightAnchor.constraint(equalToConstant: femaleRadioButton.frame.height),
            femaleRadioButton.widthAnchor.constraint(equalToConstant: femaleRadioButton.frame.width)])
    }

    @IBAction func cleckMaleButton(_ sender: Any) {
        maleRadioButton.select()
        femaleRadioButton.deselect(animated: false)
    }

    @IBAction func cleckFemaleButton(_ sender: Any) {
        femaleRadioButton.select()
        maleRadioButton.deselect(animated: false)
    }

    @IBAction func signUp(_ sender: Any) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

            let sportItemsStorybard = UIStoryboard(name: Constant.Storyboard.sportItems, bundle: nil)
            let sportItemsViewController = sportItemsStorybard.instantiateViewController(withIdentifier: Constant.Controller.sportItems) as? SportItemsViewController

            appDelegate.window?.rootViewController = sportItemsViewController
        }
    }

    @IBAction func toLogin(_ sender: Any) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {

            let loginStorybard = UIStoryboard(name: Constant.Storyboard.login, bundle: nil)
            let loginViewController = loginStorybard.instantiateViewController(withIdentifier: Constant.Controller.login) as? LoginViewController

            appDelegate.window?.rootViewController = loginViewController
        }
    }
}
