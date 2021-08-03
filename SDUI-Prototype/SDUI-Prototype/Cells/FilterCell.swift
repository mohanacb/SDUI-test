//
//  FilterCell.swift
//  SDUI-Prototype
//
//  Created by Mohana Chaudhury on 03/08/21.
//

import Foundation
import UIKit

class FilterCell: UITableViewCell {
    
    @IBOutlet weak var filterCV: UICollectionView!
    var tempModel: [String: Any] = [:]
    var filterArr: [String] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        filterCV.delegate = self
        filterCV.dataSource = self
    }
    
    func setUpCell(sectionModel: [String: Any]) {
        guard let contentModel = sectionModel["content"] as? [String: String] else { return }

        tempModel = contentModel
        
        filterArr.append(contentsOf: tempModel.values.map { String(describing: $0) })
    }
}

extension FilterCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: FilterCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCVCell", for: indexPath) as! FilterCVCell
       // let currentkey = keys[indexPath.item]
        let cellData = self.filterArr[indexPath.item] as? String
        cell.setUp(model: cellData)
        return cell
    }
        
}
