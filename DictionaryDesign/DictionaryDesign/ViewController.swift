//
//  ViewController.swift
//  DictionaryDesign
//
//  Created by ArdaSisli on 1.01.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var WordTableView: UITableView!
    
    var Words = [Kelimeler]()
    var searchWords = [Kelimeler]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataCopy()
        
        SearchBar.delegate = self
        WordTableView.delegate = self
        WordTableView.dataSource = self
        
        Words = Worddao().allDictionaryGet()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let temp = sender as? Int {
        let ComingVC = segue.destination as! ViewController2
        ComingVC.message = Words[temp]
        }
    }
    
    func DataCopy() {
    let bundlePath = Bundle.main.path(forResource: "sozluk", ofType: ".sqlite")
    let targetPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    let filemenager = FileManager.default
    let copyPath = URL(fileURLWithPath: targetPath).appendingPathComponent("sozluk.sqlite")
    if filemenager.fileExists(atPath: copyPath.path) {
        print("veri zaten var")
        
    }else{
        
        do {
            
        try filemenager.copyItem(atPath: bundlePath! , toPath: copyPath.path)
            
        }catch{
            print(error)
            
            }
        }
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return Words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let come = Words[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.English.text = come.ingilizce
        cell.Turkce.text = come.turkce
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "1To2" , sender: indexPath.row)
    }
}

extension ViewController:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        Words = Worddao().DoSearch(ingilizce: searchText)
        WordTableView.reloadData()
    }
}

