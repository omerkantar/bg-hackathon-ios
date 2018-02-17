//
//  SelectRequestViewController.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit


fileprivate let kCellIdetifier = String()
class SelectRequestViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!

    var target: RequestTarget = .getMyPacks
    
    var viewModel = SelectRequestTableViewModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildTableView()
        
    }
    
    
    func buildTableView() {
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: kCellIdetifier, bundle: nil), forCellReuseIdentifier: kCellIdetifier)
        tableView.delegate = self
        tableView.dataSource = self
    }

}


// MARK: - TableViewDataSource
extension SelectRequestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdetifier, for: indexPath) as! RequestTableViewCell
        
        return cell
    }
}

// MARK: - TableViewDelegate
extension SelectRequestViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Load
extension SelectRequestViewController {
    override func loadData() {
        request(target: self.target, loadingView: self.tableView) { (responseModel) in
            self.viewModel.build(responseModel: responseModel)
        }
    }
}
