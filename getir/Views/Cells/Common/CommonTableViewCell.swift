//
//  CommonTableViewCell.swift
//  getir
//
//  Created by omer kantar on 17.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import AlamofireImage

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
        self.selectionStyle = .none
        if let containerView = containerView {
            containerView.backgroundColor = UIColor.groupTableViewBackground.withAlphaComponent(0.2)
            containerView.layer.cornerRadius = 3.0
        }
        
        if let weightContainerView = weightContainerView {
            weightContainerView.layer.cornerRadius = weightContainerView.bounds.width / 2.0
            weightContainerView.layer.borderColor = UIColor.groupTableViewBackground.cgColor
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
    
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if let containerView = containerView {
            var alpha: CGFloat = 0.2
            var scale: CGFloat = 1.0
            if highlighted {
                // MARK: - 1989 Semih Ozturk anisina 😢
                scale = 0.98
                alpha = 0.89
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                containerView.backgroundColor = UIColor.groupTableViewBackground.withAlphaComponent(alpha)
                containerView.transform = CGAffineTransform(scaleX: scale, y: scale)
            })
        }
    }
    
    func build(viewModel: CommonCellViewModel) {
        self.viewModel = viewModel
        if let usernameLabel = usernameLabel {
            usernameLabel.text = viewModel.usernameText
        }
    }

}
