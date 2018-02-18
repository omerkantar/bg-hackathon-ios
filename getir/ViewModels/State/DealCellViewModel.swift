//
//  DealCellViewModel.swift
//  getir
//
//  Created by omer kantar on 18.02.2018.
//  Copyright © 2018 cool. All rights reserved.
//

import UIKit

class DealCellViewModel {

    var model: DealStateModel
    var statusText: String?
    
    init(model: DealStateModel) {
        self.model = model
        guard let to = model.travel?.to else {
            return
        }
        switch model.statusType {
        case .arrived:
            self.statusText = "Durum: Paket " + to + " ulaştı. 💃"
            break
        case .moving:
            self.statusText = "Durum: Paket en kısa zamanda ulaşacak. 🚀"
            break
        case .waiting:
            self.statusText = "Durum: Paket teslimi için bekleniyor."
        default:
            break
        }
    }
}
