//
//  CommonCellViewModel.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

class CommonCellViewModel {

    var activityModel: ActivityModel
    var usernameText: String?
    var userPhotoUrl: URL?
    var directionText: String?
    var weightText: String?
    var dateText: String?
    
    init(activity: ActivityModel) {
        self.activityModel = activity
        self.usernameText = activity.user?.name
        self.userPhotoUrl = activity.user?.photo?.imageURL
        self.directionText = activity.direction
        self.weightText = "\(activity.weight)\nkg"
        
        if activity is TravelModel {
            self.dateText = (activity as? TravelModel)?.date?.dateText
        }
    }
}
