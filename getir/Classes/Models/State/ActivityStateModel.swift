//
//  UserRequestModel.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import ObjectMapper

enum ActivityStateType {
    case request
    case deal
}

class ActivityStateModel: BaseModel {

    var travel: TravelModel?
    var pack: PackModel?
    var status: String?
    
    var type: ActivityStateType = ActivityStateType.request
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        travel <- map["travel"]
        pack <- map["pack"]
        status <- map["status"]
    }
}
