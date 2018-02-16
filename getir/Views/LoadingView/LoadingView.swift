//
//  LoadingView.swift
//  getir
//
//  Created by omer kantar on 16.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

class LoadingView: UIView {

    var activityIndicatorView: UIActivityIndicatorView?
    
    static func show(parentView: UIView) {
        
    }
    
    func remove() {
        self.activityIndicatorView?.stopAnimating()
        self.activityIndicatorView?.isHidden = true
        self.removeFromSuperview()
    }
}


// MARK: - Build
fileprivate extension LoadingView {
    func build(parentView: UIView) {
        
    }
}
