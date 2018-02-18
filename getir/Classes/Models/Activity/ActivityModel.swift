//
//  ActivityModel.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import ObjectMapper

class ActivityModel: BaseModel {
    
    var weight: Int = 0
    var user: UserModel?
    var to: String?
    var from: String?
    
    var direction: String? {
        if let to = to, let from = from {
            return "\(from) ✈️  \(to)"
        }
        return ""
    }
    
    var dateText: String? {
        if self is TravelModel {
            return (self as? TravelModel)?.date?.dateText
        }
        return nil
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        weight <- map["weight"]
        to <- map["to"]
        from <- map["from"]
        user <- map["user"]
    }
    
    
    var parameters: [String: Any] {
        var params = [String: Any]()
        if let from = from {
            params["from"] = from as Any
        }
        if let to = to {
            params["to"] = to as Any
        }
        params["weight"] = weight as Any
        
        if self is TravelModel {
            if let date = (self as? TravelModel)?.date {
                params["date"] = date as Any
            }
        }
        if let id = UserModel.current.id {
            params["user"] = id
        }
        return params
    }
    
}
