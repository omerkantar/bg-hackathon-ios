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

    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdetifier, for: indexPath) as! RequestTableViewCell
        
        
    }
}

// MARK: - TableViewDelegate
extension SelectRequestViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
