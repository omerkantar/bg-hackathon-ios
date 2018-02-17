//
//  SelectRequestCellViewModel.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

class SelectRequestCellViewModel {

    var activityModel: ActivityModel?
    var directionText: String?
    var dateText: String?
    var weightText: String?

    init(activity: ActivityModel) {
        self.activityModel = activity
        self.directionText = activity.direction
        self.weightText = "\(activity.weight)\nkg"
        self.dateText = activity.dateText
    }
    
    func isValidate(activity: ActivityModel) -> Bool {
        if let from = activity.from,
            let to = activity.to,
            let currentTo = self.activityModel?.to,
            let currentFrom = self.activityModel?.from {
            return from.lowercased() == currentFrom.lowercased() && to.lowercased() == currentTo.lowercased()
        }
        
        return false
    }
}
