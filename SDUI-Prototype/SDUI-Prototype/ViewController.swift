//
//  ViewController.swift
//  SDUI-Prototype
//
//  Created by Mohana Chaudhury on 02/08/21.
//

import UIKit

class ViewController: UIViewController {

    var viewModel: ListingVM = ListingVM()
    @IBOutlet weak var listTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.delegate = self
        viewModel.getListData()
        listTV.delegate = self
        listTV.dataSource = self
    }
}

extension ViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return aut
//    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.listArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = viewModel.listArr[indexPath.row], let displaySection = data["section"] as? [String:Any] else { return UITableViewCell() }
        let displayType = DisplaySectionTypes(rawValue: displaySection["id"] as! String)
        switch displayType {
        case .navigation:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NavCell", for: indexPath) as! NavCell
            cell.setUpCell(sectionModel: displaySection)
            return cell
            
        case .filter:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as! FilterCell
            cell.setUpCell(sectionModel: displaySection)
            return cell
            
        case .info:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SectionTitleCell", for: indexPath) as! SectionTitleCell
            cell.setUpCell(sectionModel: displaySection)
            return cell
            
        case .card:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CardCell", for: indexPath) as! CardCell
            cell.setUpCell(sectionModel: displaySection)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}

extension ViewController: ListingVMProtocol {
    func reloadTable() {
        DispatchQueue.main.async { [weak self] in
            self?.listTV.reloadData()
        }
    }
}
