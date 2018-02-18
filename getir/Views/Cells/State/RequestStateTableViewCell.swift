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

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        requestTypeLabel.layer.cornerRadius = 3.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
