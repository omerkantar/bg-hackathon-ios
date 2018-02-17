//
//  UIViewController.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit


// MARK: - AlertView & ActionSheet

extension UIViewController {
    
    func showAlertController(title: String?, message: String?, buttonTitles: [String], actionCompletion: ((_ buttonTitle: String, _ index: Int) -> ())? = nil) {
        
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for title in buttonTitles {
            
            let action = UIAlertAction(title: title, style: .default, handler: { (act: UIAlertAction) in
                if let actionCompletion = actionCompletion {
                    actionCompletion(title, alertController.actions.index(of: act)!)
                }
            })
            alertController.addAction(action)
        }
        
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    
    func showActionSheetController(title: String?, message: String?, buttonTitles: [String], actionCompletion: ((_ buttonTitle: String, _ index: Int) -> ())? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let color = UIColor.orange
        
        for title in buttonTitles {
            
            let action = UIAlertAction(title: title, style: .default, handler: { (act: UIAlertAction) in
                if let actionCompletion = actionCompletion {
                    actionCompletion(title, alertController.actions.index(of: act)!)
                }
            })
            
            alertController.addAction(action)
        }
        
        alertController.addAction(UIAlertAction(title: "İptal", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
        
        alertController.view.tintColor = color
        
    }
}
