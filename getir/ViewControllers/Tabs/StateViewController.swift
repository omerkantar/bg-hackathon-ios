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
    var dealsVC = DealsViewController()
    var requestsVC = RequestsViewController()
    
    var activeButton: UIButton?
    var currentPage: Int  {
        if let activeButton = activeButton {
            if activeButton == requestsButton {
                return 0
            }
        }
        return 1
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        self.pageViewController = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController?.pageDelegate = self
        pageViewController?.tabViewControllers = [requestsVC, dealsVC]
        self.containerView.addSubview(pageViewController!.view)
        self.addChildViewController(pageViewController!)

        noneSelected(button: dealsButton)
        selected(button: requestsButton)
        DispatchQueue.main.async {
            self.updatePageViewControllerSize()
        }
    }
    
    func updatePageViewControllerSize() {
        guard let pageVC = pageViewController else {
            return
        }
        
        pageVC.view.frame = CGRect(origin: CGPoint.zero, size: self.containerView.frame.size)
    }
    
    func designing(_ page: Int?) {
        noneSelected(button: activeButton)
        if page == 0 {
            selected(button: requestsButton)
        } else {
            selected(button: dealsButton)
        }
    }
    
    func noneSelected(button: UIButton?) {
        guard let button = button else {
            return
        }
        button.setTitleColor(UIColor.gray, for: .normal)
    }

    func selected(button: UIButton?) {
        guard let button = button else {
            return
        }
        button.setTitleColor(UIColor.orange, for: .normal)
        self.activeButton = button
    }
    
    // MARK: - Actions
    @IBAction func dealsButtonTapped() {
        if currentPage == 1 {
            return
        }
        self.pageVCWillChangeDisplayPageIfNeeded(1)
    }
    
    @IBAction func requestsButtonTapped() {
        if currentPage == 0 {
            return
        }
        self.pageVCWillChangeDisplayPageIfNeeded(0)
    }
    
    
    func pageVCWillChangeDisplayPageIfNeeded(_ selectedRow: Int) {
        guard let pageVC = pageViewController else {
            return
        }
        if let index = pageVC.currentIndex {
            if index == selectedRow {
                return
            }
        }
        pageVC.displayControllerWithIndex(selectedRow, animated: true)
        designing(selectedRow)
    }
}

// MARK: - PageControllerDelegate
extension StateViewController: PageViewControllerDelegate {
    func pageViewController(pageVC: PageViewController, didChanged currentPage: Int) {
        if self.currentPage == currentPage {
            return
        }
        designing(currentPage)
    }
}
