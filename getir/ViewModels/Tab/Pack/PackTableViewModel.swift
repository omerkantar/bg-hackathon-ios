//
//  PackTableViewModel.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import ObjectMapper

class PackTableViewModel: BaseViewModel {

    var cellVMs = [PackCellViewModel]()
    
    override func build(responseModel: ResponseModel) {
        if let packs = Mapper<PackModel>().mapArray(JSONObject: responseModel.data) {
            cellVMs.removeAll()
            for pack in packs {
                
            }
            
        }
    }
}
