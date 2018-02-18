//
//  StateTableViewCell.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

class RequestStateTableViewCell: CommonTableViewCell {

    @IBOutlet weak var requestTypeLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        requestTypeLabel.layer.cornerRadius = 3.0
        requestTypeLabel.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func build(viewModel: CommonCellViewModel) {
        super.build(viewModel: viewModel)
        requestTypeLabel.text = viewModel.requestUserType
        
        if let model = viewModel.requestStateModel {
            self.statusButton.setTitle(model.statusType.buttonText, for: .normal)
            self.statusButton.setTitleColor(model.statusType.color, for: .normal)
        }
    }
    
}
