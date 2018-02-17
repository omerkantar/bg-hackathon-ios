//
//  RequestStateModel.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import ObjectMapper

enum RequestStatusType: String {
    case none = "none"
    case pending = "PENDING"
    case approved = "APPROVED"
    case rejected = "REJECTTED"
    
}

class RequestStateModel: ActivityStateModel {
    
    var statusType: RequestStatusType {
        if let status = self.status,
            let type = RequestStatusType(rawValue: status) {
            return type
        }
        return .none
    }

}
