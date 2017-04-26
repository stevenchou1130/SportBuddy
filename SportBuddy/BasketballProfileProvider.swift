//
//  BasketballProfileProvider.swift
//  SportBuddy
//
//  Created by steven.chou on 2017/4/26.
//  Copyright © 2017年 stevenchou. All rights reserved.
//

import Firebase

class BasketballProfileProvider {

    static let shared = BasketballProfileProvider()
    
    func getUserJoinedGames(currentUserUID: String) {

        let ref = FIRDatabase.database().reference()
            .child(Constant.FirebaseUserGameList.nodeName)
            .child(currentUserUID)

        
    }
}
