//
//  ActivityModel.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import ObjectMapper

enum ActivityType {
    case pack
    case travel
}

class ActivityModel: BaseModel {
    
    var weight: Int = 0
    var user: UserModel?
    var to: String?
    var from: String?
    var createAt: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        weight <- map["weight"]
        to <- map["to"]
        from <- map["from"]
        date <- map["date"]
        createAt <- map["create_at"]
    }
}
