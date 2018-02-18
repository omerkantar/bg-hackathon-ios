//
//  RequestsViewController.swift
//  getir
//
//  Created by omer kantar on 18.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import ObjectMapper

fileprivate let kCellIdentifier = String(describing: RequestStateTableViewCell.self)

class RequestsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var cellVMs: [CommonCellViewModel]?
    
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
        request(target: .getMyRequests, success: { (response) in
            self.loadedData(response: response)
        }) { (error, response) in
            
        }
    }
    
    func loadedData(response: ResponseModel) {
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl?.endRefreshing()
        } 
        if let list = Mapper<RequestStateModel>().mapArray(JSONObject: response.data) {
            self.cellVMs = [CommonCellViewModel]()
            for item in list {
                self.cellVMs?.append(CommonCellViewModel(requestStateModel: item))
            }
            
            self.tableView.reloadData()
        }
    }
    
    override func tableViewRefreshing() {
        loadData()
    }
    
}

extension RequestsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = cellVMs {
            return list.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as! RequestStateTableViewCell
        if let vm = cellVMs?[indexPath.row] {
            cell.build(viewModel: vm)
        }
        return cell
    }
}

extension RequestsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let vm = cellVMs?[indexPath.row], let model = vm.requestStateModel else {
            return
        }
        guard let name = model.sentFrom?.name else {
            return
        }
        switch model.statusType {
        case .pending:
            
            self.showAlertController(title: "Emin misin?", message: name + " isteğini kabul ediyor musunuz?", buttonTitles: ["Onayla", "Reddet", "İptal"], actionCompletion: { (title, index) in
                
                switch title {
                case "Reddet":
                    self.createDealRequest(model, status: .rejected)

                    break
                case "Onayla":
                    self.createDealRequest(model, status: .approved)
                    break
                default:
                    break
                }
                
            })
            break
        case .approved:
        
            break
        case .rejected:
            self.showAlertController(title: "Rededildi.", message: nil, buttonTitles: ["Tamam"])
            break
        default:
             break
        }
        
    }
    
    func createDealRequest(_ model: RequestStateModel, status: RequestStatusType) {
        
        self.request(target: .putRequest(id: model.id!, status: status), success: { (response) in
            
            self.loadData()
        }) { (error, model) in
            
        }
    }
}
