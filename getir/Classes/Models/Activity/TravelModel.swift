//
//  TravelModel.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import ObjectMapper

class TravelModel: ActivityModel {

    var date: String?
    override func mapping(map: Map) {
        super.mapping(map: map)
        date <- map["date"]
    }
}
