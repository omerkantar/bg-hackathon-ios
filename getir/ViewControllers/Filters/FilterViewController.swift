//
//  PackFilterViewController.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

enum FilterType {
    case pack
    case travel
}

class FilterViewController: BaseViewController {

    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var dateInformationLabel:UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var delegate: FilterDelegate?
    var filterModel = FilterModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        build()
    }

    
    // MARK: - Action
    @IBAction func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func filterButtonTapped() {
        if let delegate = delegate {
            delegate.updateFilterModel(filterModel)
        }
    }
}

// MARK: - Build
extension FilterViewController {
    func build() {
        scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 10.0, 0.0)
        
        fromTextField.delegate = self
        toTextField.delegate = self
        weightTextField.delegate = self
        startDateTextField.delegate = self
        endDateTextField.delegate = self
        
        if let delegate = delegate {
            filterModel = delegate.filterModel()
            switch delegate.filterType {
            case .pack:
                self.dateInformationLabel.text = "Paketin son tarihini ya da belirli bir aralığını giriniz."
                break
            case .travel:
                self.dateInformationLabel.text = "Gezginlerin hareket ettiği tarihi ya da belirli bir tarih aralığını giriniz."

                break
            }
        }
        fromTextField.designing()
        toTextField.designing()
        weightTextField.designing()
        startDateTextField.designing()
        endDateTextField.designing()
        
    }
}

// MARK: - UITextFieldDelegate
extension FilterViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        switch textField {
        case fromTextField, toTextField:
            pushSearchPlaceVC(search: textField.placeholder)
            return false
        case startDateTextField, endDateTextField:
            
            let datePicker = UIDatePicker()
            datePicker.tag = textField.tag + 100
            datePicker.datePickerMode = .date
            textField.inputView = datePicker
            datePicker.addTarget(self, action: #selector(FilterViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
            return true
        default:
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    
    @objc func datePickerValueChanged(_ picker: UIDatePicker) {
        let date = picker.date
        if let textField = self.view.viewWithTag(picker.tag - 100) as? UITextField {
            textField.text = date.string
        }
    }
}
