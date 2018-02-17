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
    var sendDate: Date?
    var fromPlace: String?
    var toPlace: String?

    
    var parameters: [String: Any]? {
        var parameters = [String: Any]()
        if let weight = weight {
            parameters["w"] = weight as Any
        }
        if let startDate = startDate,
            let endDate = endDate {
            parameters["startDate"] = startDate.sortString as Any
            parameters["endDate"] = endDate.sortString as Any
        }
        
        if let fromPlace = fromPlace {
            parameters["f"] = fromPlace
        }
        
        if let toPlace = toPlace {
            parameters["t"] = toPlace
        }
        
        if let date = sendDate {
            parameters["d"] = date.sortString
        }
        
        if parameters.keys.count == 0 {
            return nil
        }
        return parameters
    }
}
