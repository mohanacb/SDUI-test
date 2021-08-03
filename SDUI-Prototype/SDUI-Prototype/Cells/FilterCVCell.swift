//
//  FilterCVCell.swift
//  SDUI-Prototype
//
//  Created by Mohana Chaudhury on 03/08/21.
//

import Foundation
import UIKit

class FilterCVCell: UICollectionViewCell {
    @IBOutlet weak var filterButton: UIButton!
    
    func setUp(model: String?) {
        filterButton.setTitle(model, for: .normal)
    }
}
