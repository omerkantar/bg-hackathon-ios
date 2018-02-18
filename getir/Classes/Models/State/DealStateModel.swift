//
//  DealStateModel.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import ObjectMapper

// MARK: - Çok katmanlı Model 🧝‍♂️ DealStateMode -> ActivitySateModel -> BaseModel

enum DetalStatusType: String {
    case none = "none"
    case waiting = "WAITING"
    case moving = "MOVING"
    case arrived = "ARRIVED"
}

class DealStateModel: ActivityStateModel {

    var statusType: DetalStatusType {
        if let status = self.status,
            let type = DetalStatusType(rawValue: status) {
            return type
        }
        return .none
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        self.type = .deal
    }
    
}
