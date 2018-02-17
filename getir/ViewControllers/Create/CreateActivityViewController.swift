//
//  CreateActivityViewController.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import RNLoadingButton_Swift
import GooglePlaces

class CreateActivityViewController: BaseViewController {

    @IBOutlet weak var informationLabel:UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var createButton: RNLoadingButton!
    
    var model: TravelModel = TravelModel()
    var isTravel: Bool = false
    
    var activeTextField: UITextField?
    
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
        
        self.informationLabel.text = "Seyahat bilgilerinizi giriniz."
        if !isTravel {
            self.informationLabel.text = "Paket bilgilerinizi giriniz."
            self.dateTextField.isHidden = true
        }
        
        fromTextField.text = model.from
        toTextField.text = model.to
        
        createButton.hideTextWhenLoading = true
        createButton.isLoading = false
    }
    
    // MARK: - Actions
    @IBAction func createButtonTapped() {
        
        let validate = validation()
        
        if validate.success {
            createButton.isLoading = true
            if let txt = weightTextField.text,
                let weight = Int(txt) {
                self.model.weight = weight
            }

            let target = isTravel ? RequestTarget.createTravel(travel: model) : RequestTarget.createPack(pack: model)
            request(target: target, success: { (response) in
                self.createButton.isLoading = false
                self.dismiss(animated: true, completion: nil)
            })
            
            
        } else {
            if let message = validate.message {
                self.showAlertController(title: "Error", message: message, buttonTitles: ["Tamam"])
            }
        }
    }
    
    // MARK: - Validation
    func validation() -> (success: Bool, message: String?) {
        
        if !String.validation(string: fromTextField.text, minCharacters: 2) {
            
            return (false, message: "Lütfen nereden yolacıkacağını giriniz!")
        }
        
        if !String.validation(string: toTextField.text, minCharacters: 2) {
            
            return (false, message: "Lütfen nereye gideceğini giriniz!")
        }
        
        if !String.validation(string: weightTextField.text, minCharacters: 1) {
            
            return (false, message: "Lütfen kaç kg olduğunu giriniz!")
        }
        
        if isTravel {
            if model.date == nil || model.date == ""  {
                return (false, message: "Lütfen ne zaman seyahet edeceğinizi giriniz.")
            }
        }
        
        return (true, nil)
    }
    
    @IBAction func dismissButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }

}

// MARK: - UITextViewDelegate
extension CreateActivityViewController: UITextFieldDelegate {
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
        case dateTextField:
            
            let datePicker = UIDatePicker()
            datePicker.tag = textField.tag + 100
            datePicker.datePickerMode = .date
            textField.inputView = datePicker
            datePicker.minimumDate = Date()
            datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)
            
            
            return true
        default:
            return true
        }
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
            self.model.date = date.sortString
        }
    }

}

extension CreateActivityViewController: GMSAutocompleteViewControllerDelegate {
    
    // Handle the user's selection.
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        let name = place.name
        
        if let textField = activeTextField {
            textField.text = name
            switch textField {
            case fromTextField:
                self.model.from = name
            case toTextField:
                self.model.to = name
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

