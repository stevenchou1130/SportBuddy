//
//  User.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/3/28.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import Foundation

struct User {

    var email: String
    var name: String
    var gender: String
    var photoURL: String

    init(email: String, name: String, gender: String, photoURL: String) {

        self.email = email
        self.name = name
        self.gender = gender
        self.photoURL = photoURL
    }
}
