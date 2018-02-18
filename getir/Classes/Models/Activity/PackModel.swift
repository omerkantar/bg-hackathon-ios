//
//  PackModel.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import ObjectMapper

class PackModel: ActivityModel {

    var isMe: Bool {
        if let currentId = UserModel.current.id, let thatId = id {
            return currentId == thatId
        }
        return false
    }
}
