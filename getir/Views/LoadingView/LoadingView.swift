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
    
    static func show(parentView: UIView) -> LoadingView {
        let view = LoadingView()
        view.build()
        view.center = parentView.center
        parentView.addSubview(view)
        return view
    }
    
    func hide() {
        self.activityIndicatorView?.stopAnimating()
        self.activityIndicatorView?.isHidden = true
        self.removeFromSuperview()
    }
}


// MARK: - Build
fileprivate extension LoadingView {
    func build() {
        self.activityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.activityIndicatorView?.hidesWhenStopped = true
        self.activityIndicatorView?.startAnimating()
        self.activityIndicatorView?.color = UIColor.groupTableViewBackground
        self.frame = self.activityIndicatorView!.bounds
        self.addSubview(self.activityIndicatorView!)
    }
}
