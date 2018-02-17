//
//  PackTableViewController.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

class PackTableViewController: CommonTableViewController {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        self.type = .pack
        super.viewDidLoad()
    }
    
    // MARK: - Load Data
    override func loadData() {
        self.request(target: .users, loadingView: self.tableView, isShowingError: true) { (response) in
            
        }
    }
}
