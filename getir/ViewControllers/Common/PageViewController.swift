//
//  PageViewController.swift
//  getir
//
//  Created by omer kantar on 18.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit


protocol PageViewControllerDelegate: NSObjectProtocol {
    func pageViewController(pageVC: PageViewController, didChanged currentPage: Int)
}

class PageViewController: UIPageViewController {
    
    weak var pageDelegate: PageViewControllerDelegate?
    
    var tabViewControllers: [UIViewController] = [] {
        didSet {
            tabItemsCount = tabViewControllers.count
        }
    }
    
    var currentIndex: Int? {
        get {
            guard let viewController = viewControllers?.first else {
                return nil
            }
            return tabViewControllers.index(of: viewController)
        }
        
        set(obj) {
            if let currentIndex = obj {
                didSetCurrentIndex(currentIndex)
            }
        }
    }
    
    var beforeIndex = 0
    
    var tabItemsCount = 0
    
    var defaultContentOffsetX: CGFloat { return self.view.bounds.width }
    

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPageViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}


// MARK: - SETUP

extension PageViewController {
    func setupPageViewController() {
        
        dataSource = self
        delegate = self
        automaticallyAdjustsScrollViewInsets = false
        
        if tabViewControllers.count > 0 {
            
            setViewControllers([tabViewControllers[beforeIndex]],
                               direction: .forward,
                               animated: false,
                               completion: nil)
            
        }
        
        
    }
    
}


// MARK: - UIPageViewControllerDataSource
extension PageViewController: UIPageViewControllerDataSource {
    
    func nextViewController(_ viewController: UIViewController, isAfter: Bool) -> UIViewController? {
        
        guard var index = tabViewControllers.index(of: viewController) else {
            return nil
        }
        
        if isAfter {
            index += 1
        } else {
            index -= 1
        }
        
        if index >= 0 && index < tabViewControllers.count {
            return tabViewControllers[index]
        }
        
        return nil
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController, isAfter: false)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nextViewController(viewController, isAfter: true)
    }
}


// MARK: - UIPageControllerDelegate
extension PageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if let currentIndex = currentIndex , currentIndex < tabItemsCount {
            didSetCurrentIndex(currentIndex)
            beforeIndex = currentIndex
        }
    }
}



// MARK: - Delegate
extension PageViewController {
    func didSetCurrentIndex(_ index: Int) {
        if let pageDelegate = pageDelegate {
            pageDelegate.pageViewController(pageVC: self, didChanged: index)
        }
    }
}


// MARK: - 
extension PageViewController {
    
    func displayControllerWithIndex(_ index: Int, animated: Bool) {
        
        if currentIndex == index {
            return
        }
        var direction: UIPageViewControllerNavigationDirection = .reverse
        if let currentIndex = currentIndex,
            currentIndex < index {
            direction = .forward
        }
        beforeIndex = index
        let nextViewControllers: [UIViewController] = [tabViewControllers[index]]
        
        let completion: ((Bool) -> Void) = { [weak self] _ in
            self?.beforeIndex = index
        }
        
        setViewControllers(
            nextViewControllers,
            direction: direction,
            animated: animated,
            completion: completion)
    }
}

