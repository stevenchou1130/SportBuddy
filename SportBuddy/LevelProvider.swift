//
//  LevelManager.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/4/27.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import Foundation
import Firebase

class LevelManager {

    static let shared = LevelManager()

    typealias UserHadler = (Level?, Error?) -> Void

    func getUserInfo(currentUserUID: String, completion: @escaping UserHadler) {

        var level: Level?

        let ref = FIRDatabase.database().reference()
            .child(Constant.FirebaseLevel.nodeName)
            .child(currentUserUID)

        ref.observeSingleEvent(of: .value, with: { (snapshot) in

            if snapshot.exists() {

                guard
                    let userLevel = snapshot.value as? [String: Any]
                    else { return }

                guard
                    let baseball = userLevel[Constant.FirebaseLevel.baseball] as? String,
                    let basketball = userLevel[Constant.FirebaseLevel.basketball] as? String,
                    let jogging = userLevel[Constant.FirebaseLevel.jogging] as? String
                    else { return }

                level = Level(baseball: baseball, basketball: basketball, jogging: jogging)

            } else {
                print("=== Can't find this user")
            }

            completion(level, nil)

        }) { (error) in

            completion(nil, error)
        }
    }
}
