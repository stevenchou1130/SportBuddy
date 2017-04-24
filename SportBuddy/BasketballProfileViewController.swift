//
//  BasketballProfileViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/23.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import Firebase

class BasketballProfileViewController: BaseViewController {

    @IBOutlet weak var joinedGamesCount: UILabel!
    @IBOutlet weak var lastGameTime: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
        getUserInfo()
    }

    func setView() {

        setBackground(imageName: Constant.BackgroundName.basketball)

        setNavigationBar()

    }

    func getUserInfo() {

        let uid = FIRAuth.auth()?.currentUser?.uid

        let ref = FIRDatabase.database().reference().child(Constant.FirebaseGame.nodeName)
        ref.queryOrdered(byChild: "Members").queryEqual(toValue: uid).observeSingleEvent(of: .value, with: { (snapshot) in

            print("=== snapshot: \(snapshot)")

        })

    }

    func setNavigationBar() {

        navigationItem.leftBarButtonItem = createBackButton(action: #selector(backToSportItemsView))

        transparentizeNavigationBar(navigationController: self.navigationController)
    }

}
