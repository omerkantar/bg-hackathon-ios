//
//  StateTableViewController.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

class StateViewController: BaseViewController {

    @IBOutlet weak var requestsButton: UIButton!
    @IBOutlet weak var dealsButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    
    var pageViewController: PageViewController?

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.pageViewController = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController?.pageDelegate = self

        DispatchQueue.main.async {

        }
    }
    
    
}

// MARK: - PageControllerDelegate
extension StateViewController: PageViewControllerDelegate {
    func pageViewController(pageVC: PageViewController, didChanged currentPage: Int) {
        
    }
}
