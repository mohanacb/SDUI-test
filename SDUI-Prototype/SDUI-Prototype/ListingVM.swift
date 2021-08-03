//
//  ListingVM.swift
//  SDUI-Prototype
//
//  Created by Mohana Chaudhury on 03/08/21.
//

import Foundation

enum DisplaySectionTypes: String {
    case navigation
    case info
    case filter = "filter_1"
    case card = "card_1"
}

enum ModifiersType: String {
    case bold
}

protocol ListingVMProtocol: AnyObject {
    func reloadTable()
}

class ListingVM {
    
    var listArr: [[String: Any]?] = []
    weak var delegate: ListingVMProtocol?
    
    func getListData() {
        guard let url = URL(string: "https://run.mocky.io/v3/e1e535c0-da97-4a4a-bdca-8695a3a7a911") else { return }
        var request : URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"

        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {[weak self] data, response, error -> Void in
            do {
                let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
               // let responseModel = try? JSONDecoder().decode(ListData.self, from: data!)
                print("MODEL : ",json)
                self?.listArr = json["sections"] as! [[String : Any]?]
                self?.delegate?.reloadTable()
            } catch {
                print("error")
            }
        })
        task.resume()
    }
}
