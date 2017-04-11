//
//  NewBasketballGameViewController.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/27.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class NewBasketballGameViewController: BaseViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var courtTextField: UITextField!
    @IBOutlet weak var levelTextField: UITextField!

    var basketballCourts: [BasketballCourt] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        setView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        getCourts()
    }

    func setView() {

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear

        setBackground(imageName: Constant.BackgroundName.basketball)

    }

    func getCourts() {

        // MARK: Loading indicator
        let activityData = ActivityData()
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)

        print("===============")
        print("Constant.CurrentCity.cityName: \(Constant.CurrentCity.cityName)")

        BasketballCourtsProvider.shared.getApiData(city: Constant.CurrentCity.cityName, gymType: Constant.GymType.basketball) { (basketballCourts, error) in

            if error == nil {

                self.basketballCourts = basketballCourts!

            } else {

                // todo: error handling

            }
            print("basketballCourts?.count: \(String(describing: basketballCourts?.count))")
            print("===============")
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        }
    }

}
