//
//  CardCell.swift
//  SDUI-Prototype
//
//  Created by Mohana Chaudhury on 03/08/21.
//

import Foundation
import UIKit

class CardCell: UITableViewCell {
    
    @IBOutlet weak var docImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var header1: UILabel!
    @IBOutlet weak var header2: UILabel!
    
    @IBOutlet weak var bodyLine1: UILabel!
    @IBOutlet weak var bodyLine2: UILabel!
    @IBOutlet weak var bodyLine3: UILabel!
    
    @IBOutlet weak var primaryButton: UIButton!
    
    
    func setUpCell(sectionModel: [String: Any]) {
        guard let contentModel = sectionModel["content"] as? [String:Any] else { return }
        
        titleLabel.text = contentModel["title"] as? String
        subtitleLabel.text = contentModel["subtitle"] as? String
        header1.text = contentModel["header_line_1"] as? String
        header2.text = contentModel["header_line_2"] as? String
        
        bodyLine1.text = contentModel["body_line_1"] as? String
        bodyLine2.text = contentModel["body_line_2"] as? String
        bodyLine3.text = contentModel["body_line_3"] as? String
        
        primaryButton.setTitle(contentModel["primary_cta_text"] as? String, for: .normal)
        // add support for images similarly
        // check for modifiers
        if let modifiers = sectionModel["modifiers"] as? [String : Any], !modifiers.isEmpty {
            if let boldArr = modifiers["bold"] as? [[String:String]], !boldArr.isEmpty  {
                for mod in boldArr {
                    switch mod["element"] {
                    case "header_line_1":

                        header1.attributedText = applyModifier(modData: mod, mainStr:  contentModel[mod["element"] ?? ""] as! NSString)
                        
                    case "header_line_2":

                        header2.attributedText = applyModifier(modData: mod, mainStr:  contentModel[mod["element"] ?? ""] as! NSString)
                        
                    default:
                        break
                    }
                }
            }
        }
        
    }
    
    private func applyModifier(modData: [String:String], mainStr: NSString) -> NSMutableAttributedString? {
        
        let subString = modData["display_text"] ?? ""
        let fullStr = mainStr
        let idString = modData["identifier"] ?? ""

        let myAttribute = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0, weight: .bold)]
        let myAttrString = NSMutableAttributedString(string: subString, attributes: myAttribute)

        let fullAttrStr = NSMutableAttributedString(string: fullStr as String)
        let range = fullStr.range(of: idString)
        fullAttrStr.replaceCharacters(in: range, with: myAttrString)
        return fullAttrStr
    }
}
