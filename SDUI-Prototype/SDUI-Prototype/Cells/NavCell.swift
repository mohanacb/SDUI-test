//
//  NavCell.swift
//  SDUI-Prototype
//
//  Created by Mohana Chaudhury on 03/08/21.
//

import Foundation
import UIKit

class NavCell: UITableViewCell {
    
    @IBOutlet weak var ctaButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    func setUpCell(sectionModel: [String: Any]) {
        guard let contentModel = sectionModel["content"] as? [String:Any] else { return }
        titleLabel.text = contentModel["title"] as? String
    }
}
