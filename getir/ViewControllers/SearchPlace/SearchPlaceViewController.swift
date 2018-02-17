//
//  SearchPlaceViewController.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

class SearchPlaceViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!

    var searchBar: UISearchBar?
    var searchBarPlaceholder: String?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        desigingSearchNavigationBar()
    }
    
    // MARK: - NavigationBar Search
    func desigingSearchNavigationBar() {
        DispatchQueue.main.async {
            let screenWidth: CGFloat = UIScreen.main.bounds.width
            self.searchBar = UISearchBar(frame: CGRect(x: 20.0, y: 20.0, width: screenWidth, height: 44.0))
            self.searchBar?.searchBarStyle = UISearchBarStyle.minimal
            self.searchBar?.delegate = self
            self.searchBar?.placeholder = self.searchBarPlaceholder
            self.navigationItem.titleView = self.searchBar
        }
    }

}


// MARK: - UISearchBarDelegate
extension SearchPlaceViewController: UISearchBarDelegate {
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard searchText.count > 1 else {
//            self.filteredList = self.placeList
//            reloadFilteredData()
            return
        }
        
//        let list = self.placeList?.lazy.filter({ (place) -> Bool in
//            if let name = place.name {
//                return name.lowercased().contains(searchText.lowercased())
//            }
//            return false
//        })
//
//        if let list = list {
//            self.filteredList = Array(list)
//            reloadFilteredData()
//        } else {
//            self.filteredList = [Place]()
//            reloadFilteredData()
//        }
    }
}

