//
//  TravelTableViewController.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import ObjectMapper

class TravelTableViewController: CommonTableViewController {

    
    var filter = FilterModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        self.type = .travel
        super.viewDidLoad()
    }

    
    // MARK: - Load Data
    override func loadData() {
        self.request(target: .getTravels(filter: filter), loadingView: self.tableView, isShowingError: true) { (response) in
            self.loadedResponse(response)
        }
    }
    
    func loadedResponse(_ response: ResponseModel) {
        if let travels = Mapper<TravelModel>().mapArray(JSONObject: response.data) {
            self.cellVMs = [CommonCellViewModel]()
            for travel in travels {
                cellVMs?.append(CommonCellViewModel(activity: travel))
            }
            self.tableView.reloadData()
        }
    }
    
    override func refreshingData() {
        self.filter = FilterModel()
        self.loadData()
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
        self.loadData()
    }
}
