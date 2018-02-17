//
//  BaseModel.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import ObjectMapper

class BaseModel: Mappable {
    
    
    var id: String?
    var createAt: String?

    init() { }
    
    init(id: String) {
        self.id = id
    }
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["_id"]
        createAt <- map["create_at"]
    }
}
