//
//  SelectRequestViewController.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit


fileprivate let kCellIdetifier = String(describing: RequestTableViewCell.self)
class SelectRequestViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    var selectedActivity: ActivityModel?
    
    var target: RequestTarget = .getMyPacks
    
    var viewModel = SelectRequestTableViewModel()
    
    var isMyPacks = false
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        buildTableView()
        
        switch self.target {
        case .getMyPacks:
            self.isMyPacks = true
            self.addButton.setTitle("Paket ekle", for: .normal)
            self.title = "Eşleşen Paketlerim"
            break
        case .getMyTravels:
            self.title = "Eşleşen Gezilerim"
            self.addButton.setTitle("Gezi ekle", for: .normal)
            break
        default:
            break
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
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
    
    
    override func isHiddenBottomBar() -> Bool {
        return true
    }
    
    // MARK: - Action
    @IBAction func addButtonTapped() {
        
        let nc = self.storyboard?.instantiateViewController(withIdentifier: "createActivityNC") as! UINavigationController
        if let vc = nc.viewControllers.first as? CreateActivityViewController {
            vc.isTravel = !self.isMyPacks
            vc.model.from = self.selectedActivity?.from
            vc.model.to = self.selectedActivity?.to
            self.present(nc, animated: false, completion: nil)
        }
        
    }

}


// MARK: - TableViewDataSource
extension SelectRequestViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = viewModel.cellVMs {
            return list.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdetifier, for: indexPath) as! RequestTableViewCell
        cell.viewModel = viewModel.cellVMs?[indexPath.row]
        return cell
    }
}

// MARK: - TableViewDelegate
extension SelectRequestViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let activity = viewModel.cellVMs?[indexPath.row].activityModel , let user = activity.user, let name = user.name else {
            return
        }
        
        
        let message: String = isMyPacks  ? "Paketinizin ulaşımı için \(name)'ya öneride bulunmak ister misiniz?." : "Gezideki yolculuğunuzda \(name)'nin valizini taşınması için öneride bulunmak ister misin?"
        
        self.showAlertController(title: "Emin misiniz?", message: message, buttonTitles: ["Öneride bulun", "İptal"], actionCompletion: { (title, index) in
            if title == "Öneride bulun" {
                self.createRequest(activityModel: activity)
            }
        })
       
    }
    
    func createRequest(activityModel: ActivityModel) {
        let model = ActivityStateModel()
        let pack = PackModel()
        let travel = TravelModel()
        if self.isMyPacks {
            pack.user = activityModel.user
            pack.id = activityModel.id
            travel.user = selectedActivity?.user
            travel.id = selectedActivity?.id
        } else {
            pack.user = selectedActivity?.user
            pack.id = selectedActivity?.id
            travel.user = activityModel.user
            travel.id = activityModel.id
        }

        model.pack = pack
        model.travel = travel

        self.request(target: .createRequest(request: model)) { (response) in
            
            self.navigationController?.popViewController(animated: true)
            NotificationCenter.default.post(name: Notification.Name.pendingRequest, object: nil)
        }
    }
    
    
    
}

// MARK: - Load
extension SelectRequestViewController {
    override func loadData() {
        guard let selectedActivity = selectedActivity else {
            return
        }
        
        let views = self.tableView.subviews
        for item in views {
            if item is EmptyStateView {
                item.removeFromSuperview()
            }
        }
        
        request(target: self.target, loadingView: self.tableView) { (responseModel) in
            self.viewModel.build(responseModel: responseModel, selectedActivity: selectedActivity)
            self.tableView.reloadData()
            
            if self.viewModel.cellVMs!.count == 0 {
                if let title = self.title {
                    let _ = EmptyStateView.show(information: title + " Bulunamadı isterseniz ekleyebilirsiniz.", parentView: self.tableView)
                    

                }
            }
        }
    }
}
