//
//  User.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import ObjectMapper

fileprivate let kCurrentIdentifier = "5a88b2145e758d6f85590996"

class UserModel: BaseModel {
    
    static var current = UserModel(id: kCurrentIdentifier)
    var name: String?
    var email: String?
    var username: String?
    var photo: String?
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
        email <- map["email"]
        username <- map["username"]
        photo <- map["photo"]
    }
    
}
