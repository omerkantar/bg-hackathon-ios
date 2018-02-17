//
//  TravelTableViewController.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

class TravelTableViewController: CommonTableViewController {

    
    var filter = FilterModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        self.type = .travel
        super.viewDidLoad()
    }

    
    // MARK: - Action
    @IBAction func filterButtonTapped() {
        self.presentFilterVC(delegate: self)
    }
}


// MARK: - FilterDelegate
extension TravelTableViewController: FilterDelegate {
    var filterType: FilterType {
        return .travel
    }
    
    func filterModel() -> FilterModel {
        return self.filter
    }
    
    func updateFilterModel(_ filterModel: FilterModel) {
        self.filter = filterModel
        
    }
}
