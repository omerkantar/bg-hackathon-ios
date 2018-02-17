//
//  BaseViewController.swift
//  getir
//
//  Created by omer kantar on 16.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.buildNavigationBar()
        self.loadData()
    }

}

// MARK: - NavigationBar
extension BaseViewController {
    func buildNavigationBar() {
        if #available(iOS 11.0, *) {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        } 
    }
}

// MARK: - Request Controller

extension BaseViewController {
    
    @objc func loadData() { }
    
    func request(target: RequestTarget, loadingView: UIView? = nil, isShowingError: Bool = false, success: NetworkSuccessBlock?) {

        var animatingView: LoadingView?
        
        if let loadingView = loadingView {
            animatingView = LoadingView.show(parentView: loadingView)
        }
        
        ServiceManager.request(target: target, success: { (model) in
            animatingView?.hide()
            if let success = success {
                success(model)
            }
        }) { (error, model) in
            animatingView?.hide()
            if isShowingError {
                
            }
            
            if model?.statusCode == 404 {
                self.showEmptyData(target)
            }
        }
    }

    
    func showEmptyData(_ target: RequestTarget? = nil) {
        
    }
}

// MARK: - Push&Present
extension BaseViewController {
    func presentFilterVC(delegate: FilterDelegate) {
        let nc = self.storyboard?.instantiateViewController(withIdentifier: "filterNC") as! UINavigationController
        if let rootVC = nc.viewControllers.first as? FilterViewController {
            rootVC.delegate = delegate
        }
        self.present(nc, animated: true, completion: nil)
    }
}

// MARK: - Alert & ActionSheet
