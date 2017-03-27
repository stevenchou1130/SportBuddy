//
//  BasketballCourtsManager.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/27.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import Alamofire
import CoreData

protocol BasketballCourtsManagerDelegate: class {

    func manager(_ manager: BasketballCourtsManager, didGet courts: [String])
    func manager(_ manager: BasketballCourtsManager, didFailWith error: Error)

}

class BasketballCourtsManager {

    static let shared = BasketballCourtsManager()

    weak var delegate: BasketballCourtsManagerDelegate?

    func getCourts() {

        let urlString = "http://iplay.sa.gov.tw/api/GymSearchAllList?"
        let parameters: Parameters = ["City": "新北市", "GymType": "籃球場"]

        Alamofire.request(urlString, parameters: parameters).responseJSON { response in

            if response.result.isSuccess {

                print(" === Get data is success === ")

                if let results = response.value as? [[String: AnyObject]] {
                    for result in results {
                        if let gymID = result["GymID"] {
                            print(gymID)
                        }
                    }
                } else {
                    print("Error: cover data")
                }

            } else {
                print("Error: \(response.error)")
            }
        }
    }
}
