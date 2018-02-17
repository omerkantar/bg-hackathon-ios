//
//  RequestTarget.swift
//  getir
//
//  Created by omer kantar on 16.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import Moya

fileprivate let kLocalBaseUrl = "http://192.168.88.159:8080/v1/deals"
fileprivate let kDigitalOceanBaseUrl = "http://174.138.7.62/v1"


enum RequestTarget {
    case coffee
    case call(number: Int)
    case users
    case getPacks(filter: FilterModel)
    case getTravels(filter: FilterModel)
    case getMyPacks
    case getMyTravels
}


// MARK : - TargetRequest
extension RequestTarget: TargetType {
    
    var baseURL: URL {
        
        if let url = URL(string: kDigitalOceanBaseUrl) {
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
        case .getPacks, .getMyPacks:
            return "/packs"
        case .getTravels, .getMyTravels:
            return "/travels"
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
        case .getPacks(let filter):
            return filter.parameters
        case .getTravels(let filter):
            return filter.parameters
        case .getMyPacks, .getMyTravels:
            if let id = UserModel.current.id {
                return ["u": id]
            }
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
