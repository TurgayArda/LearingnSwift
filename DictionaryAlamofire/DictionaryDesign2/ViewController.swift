//
//  ViewController.swift
//  DictionaryDesign2
//
//  Created by ArdaSisli on 7.01.2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    
    var dictionary = [Dictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        SearchBar.delegate = self
        
        AllTheWords()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let temp = sender as? Int {
            let GoingVC = segue.destination as! ViewController2
            GoingVC.messega = dictionary[temp]
        }
    }
    
    func AllTheWords() {
        AF.request("http://kasimadalan.pe.hu/sozluk/tum_kelimeler.php",method: .get).response {
            (response) in
            if let data = response.data {
                do {
                    let reply = try JSONDecoder().decode(DictionaryCod.self, from: data)
                    if let ListDictionary = reply.kelimeler {
                        self.dictionary = ListDictionary
                    }
                    
                }catch{
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.TableView.reloadData()
                }
            }
        }
    }
    
    func SearchWords(SearchWords:String) {
        let parameters:Parameters = ["ingilizce":"\(SearchWords)"]
        AF.request("http://kasimadalan.pe.hu/sozluk/kelime_ara.php",method: .post,parameters: parameters).response {
            (response) in
            if let data = response.data {
                do {
                    let reply = try JSONDecoder().decode(DictionaryCod.self, from: data)
                    if let Search = reply.kelimeler {
                        self.dictionary = Search
                    }
                } catch  {
                    print(error.localizedDescription)
                }
                DispatchQueue.main.async {
                    self.TableView.reloadData()
                }
            }
        }
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dictionary.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coming = dictionary[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.ELabel.text = coming.ingilizce
        cell.TLabel.text = coming.turkce
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToDetail", sender: indexPath.row)
    }
}

extension ViewController:UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search : \(searchText)")
        SearchWords(SearchWords: searchText)
    }
       
    
}
