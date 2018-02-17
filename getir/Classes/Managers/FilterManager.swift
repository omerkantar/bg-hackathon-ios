//
//  FilterManager.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

protocol FilterDelegate {
    
    var filterType: FilterType { get }
    
    func filterModel() -> FilterModel

    func updateFilterModel(_ filterModel: FilterModel) -> Void
    
}

class FilterManager {
    
}
