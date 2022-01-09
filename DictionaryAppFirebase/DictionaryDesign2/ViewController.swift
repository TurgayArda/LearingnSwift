//
//  ViewController.swift
//  DictionaryDesign2
//
//  Created by ArdaSisli on 7.01.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    
    var dictionary = [Dictionary]()
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TableView.delegate = self
        TableView.dataSource = self
        SearchBar.delegate = self
        
        ref = Database.database().reference()
        AllTheWords()
    }
    
    func AllTheWords() {
        ref.child("kelimeler").observe(.value, with: {
            snapshot in
            if let ComingData = snapshot.value as? [String:AnyObject] {
                self.dictionary.removeAll()
                for comingline in ComingData {
                    if let dict = comingline.value as? NSDictionary {
                        let key = comingline.key
                        let ingilizce = dict["ingilizce"] as? String ?? "none"
                        let turkce = dict["turkce"] as? String ?? "none"
                        
                        let word = Dictionary(kelime_id: key, ingilizce: ingilizce, turkce: turkce)
                        self.dictionary.append(word)
                    }
                }
                DispatchQueue.main.async {
                    self.TableView.reloadData()
                }
            }
        })
    }
    
    func SearchWords(wordS:String) {
        ref.child("kelimeler").observe(.value, with: {
            snapshot in
            if let ComingData = snapshot.value as? [String:AnyObject] {
                self.dictionary.removeAll()
                for comingline in ComingData {
                    if let dict = comingline.value as? NSDictionary {
                        let key = comingline.key
                        let ingilizce = dict["ingilizce"] as? String ?? "none"
                        let turkce = dict["turkce"] as? String ?? "none"
                        
                        if ingilizce.contains(wordS) {
                            let word = Dictionary(kelime_id: key, ingilizce: ingilizce, turkce: turkce)
                                self.dictionary.append(word)
                        }
                        
                      
                       
                    }
                }
                DispatchQueue.main.async {
                    self.TableView.reloadData()
                }
            }
        })
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
        print("search : \(searchText)")
       if searchText == "" {
            AllTheWords()
        }else {
            SearchWords(wordS: searchText)
        }
       
    }
       
    
}
