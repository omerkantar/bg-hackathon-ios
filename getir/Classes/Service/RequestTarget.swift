//
//  RequestTarget.swift
//  getir
//
//  Created by omer kantar on 16.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import Moya


enum RequestTarget {
    case coffee
    case call(number: Int)
    case users
}


// MARK : - TargetRequest
extension RequestTarget: TargetType {
    
    var baseURL: URL {
        
        if let url = URL(string: "http://172.20.10.4:8080/v1") {
            return url
        }
        
        switch self {
        default:
            break
        }
        // Coffee test
        return URL(string: "https://jsonplaceholder.typicode.com/posts")!
    }
    
    var path: String {
        switch self {
        case .call(let number):
            return "/\(number)"
        case .users:
            return "/users"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        return Method.get
    }
    
    var sampleData: Data {
        return Data()
    }
    
    
    var parameters: [String: Any]? {
        switch self {
        case .call(let number):
            return ["number": number]
        default:
            break
        }
        return nil
    }
    
    var task: Task {
        if let parameters = parameters {
            return Task.requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
        return Task.requestPlain
    }
    
    var headers: [String : String]? {
        return ["content-type": "application/json"]
    }
}
