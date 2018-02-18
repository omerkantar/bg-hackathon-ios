//
//  DealViewController.swift
//  getir
//
//  Created by omer kantar on 18.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

fileprivate let kCellIdentifier = String(describing: RequestStateTableViewCell.self)

class DealsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var cellVM: [CommonCellViewModel]?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildTableView()
        loadData()

    }
    
    // MARK: - Build TableView
    func buildTableView() {
        buildTableView(tableView: tableView, cellIdentifier: kCellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func loadData() {
        request(target: .getMyDeals, success: { (response) in
            
            
        }) { (error, response) in
            
        }
    }

}

extension DealsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as! RequestStateTableViewCell
        
        return cell
    }
}

extension DealsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
