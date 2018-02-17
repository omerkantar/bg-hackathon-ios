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
    
    case createPack(pack: PackModel)
    case createTravel(travel: TravelModel)
    case createRequest(request: ActivityModel)
    case createDeal(deal: ActivityStateModel)
    
    case putRequest(id: String, status: RequestStatusType)
    case putDeal(id: String, status: DetalStatusType)
    case getMyRequests
    case getMyDeals
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
        case .getPacks, .getMyPacks, .createPack:
            return "/packs"
        case .getTravels, .getMyTravels, .createTravel:
            return "/travels"
        
        case .getMyDeals, .createDeal:
            return "/deals"
        case .getMyRequests, .createRequest:
            return "/requests"
            
        case .putDeal(let id, _):
            return "/deals/\(id)"
        case .putRequest(let id, _):
            return "/requests/\(id)"
        default:
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createRequest, .createDeal, .createTravel, .createPack:
            return Method.post
        case .putRequest, .putDeal:
            return Method.put
        default:
            break
        }
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
        case .createRequest(let request):
            return request.parameters
        case .createDeal(let deal):
            return deal.parameters
            
        case .createTravel(let travel):
            return travel.parameters
        case .createPack(let pack):
            return pack.parameters
            
        case .putRequest(_, let status):
            return ["status": status.rawValue]
        case .putDeal(_, let status):
            return ["status": status.rawValue]
            
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
