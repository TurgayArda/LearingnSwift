//
//  ViewController.swift
//  MovieAppDesign
//
//  Created by ArdaSisli on 3.01.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var CaegoryTable: UITableView!
    
    var category = [Categories]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CaegoryTable.dataSource = self
        CaegoryTable.delegate = self
        
        AllTheCategiries()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let temp = sender as? Int {
            let goingVC = segue.destination as! ViewController2
            goingVC.message = category[temp]
        }
    }
    
    func AllTheCategiries() {
        let url = URL(string: "http://kasimadalan.pe.hu/filmler/tum_kategoriler.php")!
        URLSession.shared.dataTask(with: url) {
            (data,response,error) in
            if error != nil || data == nil {
                return
            }
            do {
                let answer = try JSONDecoder().decode(CategoryCod.self, from: data!)
                if let coming = answer.kategoriler {
                    self.category = coming
                }
                DispatchQueue.main.async {
                    self.CaegoryTable.reloadData()
                }
            
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let coming = category[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.CategoryName.text = coming.kategori_ad
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "1To2", sender: indexPath.row)
    }
}

