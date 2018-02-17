//
//  EmptyStateView.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

typealias EmptyStateViewInformationHandle = () -> Void

class EmptyStateView: UIView {

    @IBOutlet weak var informationLabel: UILabel!
    
    var tappedEmptyStateHandle: EmptyStateViewInformationHandle?
    
    static func show(information: String, parentView: UIView) -> EmptyStateView {
        let nibName = String(describing: EmptyStateView.self)
        let view = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)?.first as! EmptyStateView
        view.informationLabel.text = information
        view.frame = CGRect(x: 0.0, y: 0.0, width: parentView.bounds.width, height: 300.0)
        view.center = parentView.center
        parentView.addSubview(view)
        view.build()
        return view
    }
    
}

// MARK: - Build 🛰
fileprivate extension EmptyStateView {
    func build() {
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(informationLabelTapped))
        informationLabel.isUserInteractionEnabled = true
        informationLabel.addGestureRecognizer(tapGR)
    }
    
    @objc func informationLabelTapped() {
        
    }
}
