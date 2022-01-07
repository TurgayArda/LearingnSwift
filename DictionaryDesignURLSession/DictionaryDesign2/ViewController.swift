//
//  ViewController.swift
//  DictionaryDesign2
//
//  Created by ArdaSisli on 7.01.2022.
//

import UIKit

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
    
    func AllTheWords() {
        let url = URL(string: "http://kasimadalan.pe.hu/sozluk/tum_kelimeler.php")
        URLSession.shared.dataTask(with: url!) {
            (data,responce,error) in
            if error != nil || data == nil {
                print("error")
                return
            }
            
            do {
                let reply = try JSONDecoder().decode(DictionaryCod.self, from: data!)
                if let ComeWord = reply.kelimeler {
                    self.dictionary = ComeWord
                }
                
                DispatchQueue.main.async {
                    self.TableView.reloadData()
                }
            
            } catch  {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func SearchWords(AA:String) {
       var request = URLRequest(url: URL(string: "http://kasimadalan.pe.hu/sozluk/kelime_ara.php")!)
        
        request.httpMethod = "POST"
        
        let postString = "ingilizce=\(AA)"
        
        request.httpBody = postString.data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) {
            (data,responce,error) in
            if error != nil || data == nil {
                print("error")
                return
            }
            
            do {
                let reply = try JSONDecoder().decode(DictionaryCod.self, from: data!)
                if let ComeWord = reply.kelimeler {
                    self.dictionary = ComeWord
                    
                }
                
                DispatchQueue.main.async {
                    self.TableView.reloadData()
                }
            
            } catch  {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let temp = sender as? Int {
            let GoingVC = segue.destination as! ViewController2
            GoingVC.messega = dictionary[temp]
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
        SearchWords(AA:searchText)
    }
       
    
}
