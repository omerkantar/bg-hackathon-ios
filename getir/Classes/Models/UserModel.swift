//
//  User.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import ObjectMapper

// omer
fileprivate let kCurrentIdentifier = "5a8932e4f1b80cc4727c2b53"
// furkan
//fileprivate let kCurrentIdentifier = "5a8956ba21a6538131b9ceba"

// omergormel
//fileprivate let kCurrentIdentifier = "5a8932a9f1b80cc4727c2b52"

class UserModel: BaseModel {
    
    static var current = UserModel(id: kCurrentIdentifier)
    var name: String?
    var email: String?
    var username: String?
    var photo: String?
    
    
    var isMe: Bool {
        if let id = self.id, let currentId = UserModel.current.id {
            return id == currentId
        }
        return false
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        name <- map["name"]
        email <- map["email"]
        username <- map["username"]
        photo <- map["photo"]
    }
    
}
