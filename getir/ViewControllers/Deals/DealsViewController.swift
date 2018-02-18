//
//  DealViewController.swift
//  getir
//
//  Created by omer kantar on 18.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import ObjectMapper

fileprivate let kCellIdentifier = String(describing: DealTableViewCell.self)

class DealsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var cellVM: [DealCellViewModel]?
    
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
            self.loadedData(response: response)
        }) { (error, response) in
            
        }
    }
    
    override func tableViewRefreshing() {
        self.loadData()
    }
    
    func loadedData(response: ResponseModel) {
        
        let views = self.tableView.subviews
        for item in views {
            if item is EmptyStateView {
                item.removeFromSuperview()
            }
        }
        
        if #available(iOS 10.0, *) {
            self.tableView.refreshControl?.endRefreshing()
        }
        if let list = Mapper<DealStateModel>().mapArray(JSONObject: response.data) {
            self.cellVM = [DealCellViewModel]()
            for deal in list {
                let vm = DealCellViewModel(model: deal)
                self.cellVM?.append(vm)
            }
        }
        
        if self.cellVM!.count == 0 {
            let _ = EmptyStateView.show(information:"Henüz görüntülenecek bir antlaşmanız bulunmuyor 😢", parentView: self.tableView)
        }
        self.tableView.reloadData()
        
        
    }

}

extension DealsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = cellVM {
            return list.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as! DealTableViewCell
        cell.viewModel = cellVM?[indexPath.row]
        
        return cell
    }
}

extension DealsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        guard let vm = cellVM?[indexPath.row] else {
            return
        }
//
        if let user = vm.model.travel?.user {
            if !user.isMe {
                return
            }
        }
        
        switch vm.model.statusType {
        case .waiting:
            self.showAlertController(title: "Gezi Durumu Güncelle", message: "Geziye başladınız mı?", buttonTitles: ["Evet", "Henüz değil"], actionCompletion: { (title, index) in
                
                if title == "Evet" {
                    self.putDealStatus(vm.model, status: .moving)
                }
            } )
            break
        case .moving:
            self.showAlertController(title: "Gezi Durumu Güncelle", message: "Hedefe ulaştınız mı?", buttonTitles: ["Evet", "Henüz değil"], actionCompletion: { (title, index) in
                
                if title == "Evet" {
                    self.putDealStatus(vm.model, status: .arrived)
                }
            } )

            break
        case .arrived:
            break
        default:
            break
        }
        
    }
    
    func putDealStatus(_ deal: DealStateModel, status: DetalStatusType) {
        
        self.request(target: .putDeal(id: deal.id!, status: status), success: { (response) in
            self.loadData()
        }) { (error, response) in
            self.loadData()
        }
    }
}
