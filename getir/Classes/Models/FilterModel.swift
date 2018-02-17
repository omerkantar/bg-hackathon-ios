//
//  FilterModel.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

class FilterModel {
    
    var weight: Int?
    var startDate: Date?
    var endDate: Date?
    var fromPlace: String?
    var toPlace: String?

    
    var parameters: [String: Any]? {
        var parameters = [String: Any]()
        if let weight = weight {
            parameters["weight"] = weight as Any
        }
        if let startDate = startDate, let endDate = endDate {
            parameters["startDate"] = startDate as Any
            parameters["endDate"] = endDate as Any
        } else if let endDate = endDate {
            parameters["endDate"] = endDate
        }
        
        if let fromPlace = fromPlace {
            parameters["from"] = fromPlace
        }
        
        if let toPlace = toPlace {
            parameters["to"] = toPlace
        }
        
        return parameters
    }
}
