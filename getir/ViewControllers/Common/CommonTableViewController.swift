//
//  CommonTableViewController.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit



class CommonTableViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var type: CommonTableViewType = .pack
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildTableView()
    }
    
    // MARK: - Build
    func buildTableView() {
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        
    }
    
}

// MARK: - UITableViewDataSource


// MARK: - UITableViewDelegate


// MARK: - Enum
enum CommonTableViewType {
    case pack
    case travel
    case state
    
    var cellIdentifier: String {
        switch self {
        case .pack:
            return String(describing: PackTableViewCell.self)
        case .state:
            return String(describing: StateTableViewCell.self)
        case .travel:
            return String(describing: TravelTableViewCell.self)
        default:
            break
        }
    }
    
}
