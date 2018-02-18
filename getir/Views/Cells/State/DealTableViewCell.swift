//
//  DealTableViewCell.swift
//  getir
//
//  Created by omer kantar on 18.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

class DealTableViewCell: UITableViewCell {

    @IBOutlet weak var packInfoTitleLabel: UILabel!
    @IBOutlet weak var packOwnerNameLabel: UILabel!
    @IBOutlet weak var packSubtitleLabel: UILabel!
    @IBOutlet weak var packOwnerImageView: UIImageView!

    @IBOutlet weak var packCircleView: UIView!

    @IBOutlet weak var travelInfoTitleLabel: UILabel!
    @IBOutlet weak var travelOwnerNameLabel: UILabel!
    @IBOutlet weak var travelSubtitleLabel: UILabel!
    @IBOutlet weak var travelOwnerImageView: UIImageView!

    @IBOutlet weak var travelCircleView: UIView!

    @IBOutlet weak var statusLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        packCircleView.layer.cornerRadius = packCircleView.bounds.width / 2.0
        travelCircleView.layer.cornerRadius = travelCircleView.bounds.width / 2.0

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
