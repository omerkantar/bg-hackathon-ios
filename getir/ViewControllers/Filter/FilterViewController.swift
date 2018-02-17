//
//  PackFilterViewController.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import GooglePlaces

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
    var activeTextField: UITextField? = nil
    
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
        updateFilterModel()
        if let delegate = delegate {
            delegate.updateFilterModel(self.filterModel)
        }
        self.dismissButtonTapped()
    }
    
    func updateFilterModel() {
        if let txt = self.weightTextField.text {
            self.filterModel.weight = Int(txt)
        }
    }
}

// MARK: - Build
extension FilterViewController {
    func build() {
        
        if let delegate = delegate {
            filterModel = delegate.filterModel()
        }
        
        scrollView.contentInset = UIEdgeInsetsMake(0.0, 0.0, 10.0, 0.0)
        
        fromTextField.delegate = self
        toTextField.delegate = self
        weightTextField.delegate = self
        startDateTextField.delegate = self
        endDateTextField.delegate = self
        
        fromTextField.text = self.filterModel.fromPlace
        toTextField.text = self.filterModel.toPlace
        
        if let weight = filterModel.weight {
            weightTextField.text = "\(weight)"
        }
        
        startDateTextField.text = filterModel.sendDate?.string
        endDateTextField.text = filterModel.endDate?.string
        
        if let delegate = delegate {
            switch delegate.filterType {
            case .pack:
                self.dateInformationLabel.text = "Paketin gönderileceği tarihi giriniz."
                self.startDateTextField.placeholder = "Gönderilecek tarih"
                self.endDateTextField.isHidden = true
                self.startDateTextField.isHidden = true
                self.dateInformationLabel.isHidden = true
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
        activeTextField = textField

        switch textField {
        case fromTextField, toTextField:
//            pushSearchPlaceVC(search: textField.placeholder)
            let autocompleteController = GMSAutocompleteViewController()
            autocompleteController.delegate = self
            autocompleteController.tintColor = UIColor.orange
            autocompleteController.navigationController?.navigationBar.tintColor = UIColor.orange
            present(autocompleteController, animated: true, completion: nil)

            return false
        case startDateTextField, endDateTextField:
            
            let datePicker = UIDatePicker()
            datePicker.tag = textField.tag + 100
            datePicker.datePickerMode = .date
            textField.inputView = datePicker
            
            if let date = filterModel.sendDate {
                datePicker.date = date
            } else if startDateTextField == textField,
                let date = filterModel.startDate {
                datePicker.date = date
            } else if endDateTextField == textField,
                let date = filterModel.endDate {
                datePicker.date = date
            }
            
            datePicker.minimumDate = Date()
            
            datePicker.addTarget(self, action: #selector(FilterViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
            
            
            return true
        default:
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField != fromTextField && textField != toTextField {
            activeTextField = nil
        }
    }
    
    
    @objc func datePickerValueChanged(_ picker: UIDatePicker) {
        let date = picker.date
        if let textField = self.view.viewWithTag(picker.tag - 100) as? UITextField {
            textField.text = date.string
            
            if let delegate = delegate {
                switch textField {
                case startDateTextField:
                    if delegate.filterType == .pack {
                        self.filterModel.sendDate = date
                    } else {
                        self.filterModel.startDate = date
                    }
                case endDateTextField:
                    self.filterModel.endDate = date
                default:
                    break
                }
            }
            
        }
    }
}


extension FilterViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let name = place.name
        
        if let textField = activeTextField {
            textField.text = name
            switch textField {
            case fromTextField:
                self.filterModel.fromPlace = name
            case toTextField:
                self.filterModel.toPlace = name
            default:
                break
            }
        }
        
        print("Place name: \(place.name)")
        print("Place attributions: \(place.attributions)")
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // User canceled the operation.
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}
