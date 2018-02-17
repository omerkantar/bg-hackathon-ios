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

    var delegate: FilterDelegate?
    var filterModel = FilterModel()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
