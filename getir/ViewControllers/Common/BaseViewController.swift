//
//  BaseViewController.swift
//  getir
//
//  Created by omer kantar on 16.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    
//    fileprivate var loadingView:
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

// MARK: - Request Controller

extension BaseViewController {
    
    func request(target: RequestTarget, loadingView: UIView? = nil,  success: NetworkSuccessBlock?) {
        
        ServiceManager.request(target: target, success: { (model) in
            
            
        }) { (error, model) in
            
        }
    }

}


// MARK: - Alert & ActionSheet
