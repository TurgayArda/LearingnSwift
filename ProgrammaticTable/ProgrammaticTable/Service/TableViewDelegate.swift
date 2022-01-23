//
//  TableViewDelegate.swift
//  ProgrammaticTable
//
//  Created by ArdaSisli on 21.01.2022.
//

import Alamofire
import UIKit

protocol RickySave {
    func saveData(value: [Result])
}

protocol IRickyDelegate {
    func select(item: Result)
}

class TableViewDelegate: NSObject{
    var contact:[Result] = []
    var rProtocol: IRickyDelegate?
    var rickyService: IRickyService = RickyService()
    }

extension TableViewDelegate: RickySave {
    func saveData(value: [Result]) {
        self.contact = value
    }
}

extension TableViewDelegate: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contact.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RickyCell.Identifier.Path.rawValue) as? RickyCell else {
            return UITableViewCell()
        }
        cell.saveModel(value: contact[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rProtocol?.select(item: contact[indexPath.row])
    }
}
