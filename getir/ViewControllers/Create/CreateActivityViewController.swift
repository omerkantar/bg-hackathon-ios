//
//  CreateActivityViewController.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

class CreateActivityViewController: BaseViewController {

    @IBOutlet weak var informationLabel:UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        build()
    }

    // MARK: - Build
    func build() {
        fromTextField.designing()
        toTextField.designing()
        weightTextField.designing()
        dateTextField.designing()
        
        fromTextField.delegate = self
        toTextField.delegate = self
        weightTextField.delegate = self
        dateTextField.delegate = self
    }
    
    // MARK: - Actions
    @IBAction func createButtonTapped() {
        
    }
    
    // MARK: - Validation
    func validation() -> (success: Bool, message: String?) {
        
        
        return (true, nil)
    }

}

// MARK: - UITextViewDelegate
extension CreateActivityViewController: UITextFieldDelegate {
    
}
