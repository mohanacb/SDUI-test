//
//  SectionTitleCell.swift
//  SDUI-Prototype
//
//  Created by Mohana Chaudhury on 03/08/21.
//

import Foundation
import UIKit

class SectionTitleCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    func setUpCell(sectionModel: [String: Any]) {
        guard let contentModel = sectionModel["content"] as? [String:Any] else { return }
        titleLabel.text = contentModel["title"] as? String
        subTitleLabel.text = contentModel["subtitle"] as? String
    }
}
