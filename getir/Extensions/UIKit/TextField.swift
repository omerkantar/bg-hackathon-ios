//
//  TextField.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

extension UITextField {
    
    func designing() {
        let view = UIView(frame: CGRect.zero)
        view.frame.size.width = 10.0
        view.backgroundColor = .clear
        self.leftView = view
        self.rightView = view
        self.leftViewMode = .always
        self.rightViewMode = .always
        self.layer.cornerRadius = 3.0
        self.backgroundColor = UIColor.groupTableViewBackground
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.borderWidth = 0.5
    }
}
