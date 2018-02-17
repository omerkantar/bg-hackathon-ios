//
//  ServiceConnector.swift
//  getir
//
//  Created by omer kantar on 16.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper
import Alamofire

typealias NetworkFailureBlock = (_ error: Error?, _ response: ResponseModel?) -> Void
typealias NetworkSuccessBlock = (_ response: ResponseModel) -> Void

class ServiceManager {

    static func request(target: RequestTarget, success: NetworkSuccessBlock?, failure: NetworkFailureBlock?) {
        
        
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        let provider = MoyaProvider<RequestTarget>()
        
        provider.request(target) { (result) in
            
            switch result {
            case .success(let moyaResponse):
                let statusCode = moyaResponse.statusCode
                do {
                    try moyaResponse.filterSuccessfulStatusCodes()
                    let data = try moyaResponse.mapJSON()
                    if let response = Mapper<ResponseModel>().map(JSONObject: data) {
                        if let block = success {
                            block(response)
                        }
                    } else {
                        if let block = failure {
                            block(nil, ResponseModel.error(type: .mapping))
                        }
                    }
                } catch let error {
                    print("Service Error:", error)
                    // show an error to your user
                    
                    if let error = error as? MoyaError {
                        do {
                            let body = try error.response?.mapJSON()
                            print(body)
                        } catch {
                            print(error)
                        }
                    }
                    
                    if let type = ResponseErrorType(rawValue: statusCode) {
                        if let block = failure {
                            block(nil, ResponseModel.error(type: type))
                        }
                    } else {
                        if let block = failure {
                            block(nil, ResponseModel.error(type: .json))
                        }
                    }
                }
                break
            case .failure(let error):
                
                if let block = failure {
                    block(error, nil)
                }
                break
            }
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }

}
