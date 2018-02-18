//
//  DealTableViewCell.swift
//  getir
//
//  Created by omer kantar on 18.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit
import AlamofireImage

class DealTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
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
    
    @IBOutlet weak var lineView: UIView!
    
    var viewModel: DealCellViewModel? {
        didSet {
            if let vm = viewModel {
                self.statusLabel.text = vm.statusText
                self.packOwnerNameLabel.text = vm.model.pack?.user?.name
                self.packSubtitleLabel.text = vm.model.pack?.from
                
                if let url = vm.model.pack?.user?.photo?.imageURL {
                    self.packOwnerImageView.af_setImage(withURL: url)
                }
                self.travelOwnerNameLabel.text = vm.model.travel?.user?.name
                self.travelSubtitleLabel.text = vm.model.travel?.direction
                if let url = vm.model.travel?.user?.photo?.imageURL {
                    self.travelOwnerImageView.af_setImage(withURL: url)
                }
                
                self.travelCircleView.isHidden = true
                self.packCircleView.isHidden = true
                
                switch vm.model.statusType {
                case .arrived:
                    self.travelCircleView.isHidden = false
                    self.packCircleView.isHidden = false
                    self.packCircleView.backgroundColor = UIColor.gray
                    self.travelCircleView.backgroundColor = UIColor.gray
                case .moving:
                    self.packCircleView.isHidden = false
                    self.packCircleView.backgroundColor = UIColor.gray
                    self.travelCircleView.backgroundColor = UIColor.white
                    self.travelCircleView.layer.borderWidth = 1.5
                case .waiting:
                    self.packCircleView.layer.borderWidth = 1.5
                    self.packCircleView.isHidden = false

                default:
                    break
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.packCircleView.layer.borderColor = UIColor.gray.cgColor
        self.travelCircleView.layer.borderColor = UIColor.gray.cgColor

        containerView.layer.cornerRadius = 5.0
        packCircleView.layer.cornerRadius = packCircleView.bounds.width / 2.0
        travelCircleView.layer.cornerRadius = travelCircleView.bounds.width / 2.0

        lineView.layer.cornerRadius = 1.5
        
        
        packOwnerImageView.layer.masksToBounds = true
        packOwnerImageView.layer.cornerRadius = packOwnerImageView.bounds.width / 2.0
        travelOwnerImageView.layer.masksToBounds = true
        travelOwnerImageView.layer.cornerRadius = travelOwnerImageView.bounds.width / 2.0

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
