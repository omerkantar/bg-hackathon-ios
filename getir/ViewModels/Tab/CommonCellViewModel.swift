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
    var requestUserType: String?
    
    
    init(activity: ActivityModel) {
        self.activityModel = activity
        self.usernameText = activity.user?.name
        self.userPhotoUrl = activity.user?.photo?.imageURL
        self.directionText = activity.direction
        self.weightText = "\(activity.weight)\nkg"
    }
    
    init(requestStateModel: RequestStateModel) {
        
        var user: UserModel? = nil
        
        if let pack = requestStateModel.pack {
            self.directionText = pack.direction + " \(pack.weight)kg"
            user = pack.user
            if pack.isMe {
                self.requestUserType = "GEZGİN"
                user = requestStateModel.travel?.user
            }
        }
       
        if let user = user {
            
            self.userPhotoUrl = user.photo?.imageURL
            
        }
        
    }
}
