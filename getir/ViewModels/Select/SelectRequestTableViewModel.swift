//
//  SelectRequestListViewModel.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import ObjectMapper

class SelectRequestTableViewModel: BaseViewModel {
    
    var cellVMs: [SelectRequestCellViewModel]?
    
    func build(responseModel: ResponseModel, selectedActivity: ActivityModel) {
        self.cellVMs = [SelectRequestCellViewModel]()
        if let list = Mapper<ActivityModel>().mapArray(JSONObject: responseModel.data) {
            for item in list {
                let vm = SelectRequestCellViewModel(activity: item)
                if vm.isValidate(activity: selectedActivity) {
                    self.cellVMs?.append(vm)
                }
            }
        }
    }


}
