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
        if let user = user {
            return user.isMe
        }
        return false
    }
}
