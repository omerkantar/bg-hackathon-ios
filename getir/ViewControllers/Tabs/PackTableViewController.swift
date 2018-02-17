//
//  PackTableViewController.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

class PackTableViewController: CommonTableViewController {

    
    var filter: FilterModel = FilterModel()
    
    var viewModel = PackTableViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        self.type = .pack
        super.viewDidLoad()
    }
    
    // MARK: - Load Data
    override func loadData() {
        self.request(target: .getPacks(filter: filter), loadingView: self.tableView, isShowingError: true) { (response) in
            self.viewModel.build(responseModel: response)
            self.cellVMs = self.viewModel.cellVMs
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Action
    @IBAction func filterButtonTapped() {
        self.presentFilterVC(delegate: self)
    }
}


extension PackTableViewController: FilterDelegate {
    var filterType: FilterType {
        return .pack
    }

    func filterModel() -> FilterModel {
        return self.filter
    }
    
    func updateFilterModel(_ filterModel: FilterModel) {
        self.filter = filterModel
    }
}

