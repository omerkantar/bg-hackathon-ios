//
//  CommonTableViewCell.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

class CommonTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userContainerView: UIView!
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightContainerView: UIView!

    var viewModel: CommonCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let containerView = containerView {
            
        }
        
        if let weightContainerView = weightContainerView {
            weightContainerView.layer.cornerRadius = weightContainerView.bounds.width / 2.0
            weightContainerView.layer.borderColor = UIColor.gray.cgColor
            weightContainerView.layer.borderWidth = 1.0
        }
        
        if let userImageView = userImageView, let userContainerView = userContainerView {
            userImageView.layer.cornerRadius = userImageView.bounds.width / 2.0
            userContainerView.layer.cornerRadius = userContainerView.bounds.width / 2.0
            userContainerView.backgroundColor = UIColor.groupTableViewBackground
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func build(viewModel: CommonCellViewModel) {
        self.viewModel = viewModel
        
    }

}
