//
//  Response.swift
//  getir
//
//  Created by omer kantar on 16.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import ObjectMapper

// MARK: - Response Model direk buradan geliyor
class ResponseModel: Mappable {

    var data: Any?
    var object: [String: Any]?
    var isSuccess: Bool = true
    var message: String?
    var statusCode = 200

    
    init() { }
    
    required init?(map: Map) {
        self.object = map.JSON
    }
    
    func mapping(map: Map) {
        data <- map["data"]
        message <- map["message"]
    }
    
    static func error(type: ResponseErrorType) -> ResponseModel {
        let model = ResponseModel()
        switch type {
        case .unauthorization:
            model.message = ""
            break
        case .notFound:
            model.message = "Not Found"
            model.statusCode = 404
            break
        default:
            break
        }
        return model
    }
}


enum ResponseErrorType: Int {
    case json = -1000
    case mapping = -1001
    case unauthorization = 401 // Unauthorization
    case notFound = 404
}
