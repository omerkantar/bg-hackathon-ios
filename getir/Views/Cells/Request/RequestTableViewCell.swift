//
//  RequestTableViewCell.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

class RequestTableViewCell: UITableViewCell {

    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    
    var viewModel: SelectRequestCellViewModel? {
        didSet {
            if let vm = viewModel,
                let directionLabel = directionLabel,
                let dateLabel = dateLabel,
                let weightLabel = weightLabel {
                
                directionLabel.text = vm.directionText
                dateLabel.text = vm.dateText
                weightLabel.text = vm.weightText
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
