//
//  ViewController.swift
//  SearchBar-TableView
//
//  Created by ArdaSisli on 27.12.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    
    var country = [String]()
    var searchResults = [String]()
    var search = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        country = ["Turkiye","Fransa","Almnaya","Rusya","Amerika","Bulgaristan","Azerbaycan"]
        
        TableView.dataSource = self
        TableView.delegate = self
        SearchBar.delegate = self
        
      
        
    }


}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if search {
            return searchResults.count
        }else{
            return country.count
        }
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if search {
            cell.textLabel?.text = searchResults[indexPath.row]
        }else{
            cell.textLabel?.text = country[indexPath.row]
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if search {
            print("Secilen ulke: \(searchResults[indexPath.row])")
        }else{
            print("Secilen ulke: \(country[indexPath.row])")
        }
       
    }
}
extension ViewController:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
      print("Arama sonucu: \(searchText)")
        search = true
        searchResults = country.filter({$0.lowercased().contains(searchText.lowercased())})
        TableView.reloadData()
    }
}

